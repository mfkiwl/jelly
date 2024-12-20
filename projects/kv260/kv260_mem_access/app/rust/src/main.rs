
use core::ptr;
use jelly_mem_access::*;

const TEST_SIZE : usize = 256*1024;

fn main() {
    access_test("[DDR4 chached]   ", "udmabuf_ddr4", "u-dma-buf", true);
    access_test("[OCM  chached]   ", "uiomem_ocm",   "uiomem",    true);
    access_test("[PL   chached]   ", "uiomem_fpd0",  "uiomem",    true);
    access_test("[DDR4 non-chache]", "udmabuf_ddr4", "u-dma-buf", false);
    access_test("[OCM  non-chache]", "uiomem_ocm",   "uiomem",    false);
    access_test("[PL   non-chache]", "uiomem_fpd0",  "uiomem",    false);
}


fn access_test(name:&str, device_name: &str, module_name: &str, cache:bool) {
    let acc = UdmabufAccessor::<usize>::new_with_module_name(device_name, module_name, cache).expect("Failed to open uiomem_ocm");
    let time = read_test(&acc, TEST_SIZE);
    println!("{} read  {:8.2} MByte/s", name, TEST_SIZE as f64 / time / 1024.0 / 1024.0);
    let time = write_test(&acc, TEST_SIZE);
    println!("{} write {:8.2} MByte/s", name, TEST_SIZE as f64 / time / 1024.0 / 1024.0);
}


fn dummy_read() {
    // 2MB buffer
    static mut BUF: [u64; 2*1024*1024] = [0; 2*1024*1024];
    // 全領域を volatile read
    unsafe {
        for i in 0..BUF.len() {
            let _ = ptr::read_volatile(&BUF[i]);
        }
    }
}


//fn read_test<T : MemAccess>(mem: &T, size: usize) -> f64 {
fn read_test(mem: &UdmabufAccessor::<usize>, size: usize) -> f64 {
    // キャッシュを飛ばすためにダミーリード
    dummy_read();

    // 時間計測開始
    let start = std::time::Instant::now();

    // ダミーリード
    unsafe {
        mem.sync_for_cpu();
        for i in 0..size/8 {
            let _ = mem.read_mem_u64(i*8);
        }
    }

    // 時間計測終了
    let end = std::time::Instant::now();

    unsafe {
        mem.sync_for_device();
    }

    // 経過時間を秒単位で返す
    let elapsed = end - start;
    elapsed.as_secs_f64()
}


fn write_test(mem: &UdmabufAccessor::<usize>, size: usize) -> f64 {
    // キャッシュを飛ばすためにダミーリード
    dummy_read();

    unsafe {
        mem.sync_for_cpu();
    }

    // 時間計測開始
    let start = std::time::Instant::now();

    // ダミーライト
    unsafe {
        for i in 0..size/8 {
            mem.write_mem_u64(i*8, i as u64);
        }
        mem.sync_for_device();
    }

    // 時間計測終了
    let end = std::time::Instant::now();

    // 経過時間を秒単位で返す
    let elapsed = end - start;
    elapsed.as_secs_f64()
}
