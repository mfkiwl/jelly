# Jelly source files


JELLY_VLOG_SOURCES  = $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_bridge_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_bridge_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_dma_addr.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_dma_reader.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_dma_writer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_read_nd.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_read_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_write_nd.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4_write_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4l_to_wishbone.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_add_control_signal.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_fifo.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_fifo_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_video_combiner.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_video_fifo.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_video_fifo_width_converter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_video_width_converter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_axi4s_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_jbus_decoder.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_jbus_to_ram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_jbus_to_wishbone.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_arbiter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_bridge.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_clk_x2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_insert_ff.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_to_axi4l.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_to_jbus.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_to_ram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_width_clk_x2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_wishbone_width_converter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_writebuffer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly_writebuffer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/cache/jelly_cache_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/cache/jelly_cache_unified.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_buffer_allocator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_buffer_manager.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_fifo.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_fifo_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_fifo_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_fifo_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_stream_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_stream_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_video_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly_dma_video_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_bilinear_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_cache_tag.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_cache_tag_directmap.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_cache_tag_full.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_cache_tag_full_associative.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_cache_tag_set_associative.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_gpu_gouraud.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_gpu_texturemap.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_gpu_texturemap_sram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_pixel_shader_gouraud.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_pixel_shader_texturemap.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_pixel_shader_texturemap_sram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_rasterizer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_rasterizer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_rasterizer_params.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_rasterizer_plane_calc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_bilinear.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_bilinear_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_blk_addr.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_border_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_basic.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_dma.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_l1.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_l2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_limitter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_lookahead.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_mem.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_tag.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_tag_addr.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_tag_associative.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_tag_directmap.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_cache_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_sampler.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_stream.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_writer_axi4.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_writer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly_texture_writer_line_to_blk.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_axi4s_img.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_axi4s_insert_blank.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_axi4s_to_img.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_absdiff.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_alpha_belnd.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_alpha_blend_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_area_mask.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_area_mask_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_binarizer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_binarizer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_blk_buffer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_canny.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_canny_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_color_matrix.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_color_matrix_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_colormap_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_delay.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi_g_calc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi_g_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi_rb_calc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_demosaic_acpi_rb_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_dnn_maxpol.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_gamma_correction.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_gamma_correction_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_gaussian_3x3.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_gaussian_3x3_calc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_gaussian_3x3_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_line_buffer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_line_buffer_series.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_mass_center.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_mass_center_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_mean_grad_to_angle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_pixel_buffer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_previous_frame.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_previous_frame_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_rgb_to_gray.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_selector.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_selector_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_sobel_calc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_sobel_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_to_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly_img_xy_ss.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi4_reader.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi4_reader_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi4_writer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi4_writer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_addr_align.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_addr_capacity.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_addr_len.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_addr_offset.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_addr_range.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_axi_data_last.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_binary_to_graycode.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_data_shifter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_fifo_fwtf2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_graycode_to_binary.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_shift.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/legacy/jelly_shift_register.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_align_split.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_generator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_generator_nd.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_generator_range.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_generator_step.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_offset.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_address_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_bit_encoder.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_bit_selector.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_bit_shift.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_buffer_arbiter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_bus_shift.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_busy_control.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_buffer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_control.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_size.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_size_limitter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_capacity_timeout.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_clkx2_demux.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_clkx2_mux.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_clkx2_phase.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_colormap.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_colormap_table.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_counter_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_crossbar.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_arbiter_crossbar.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_arbiter_ring_bus.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_combine.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_combine_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_combine_pack2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_combiner.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_crossbar_simple.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_delay.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_demultiplexer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_deserializer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_expand.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_ff.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_ff_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_frame_combiner.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_gather.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_joint.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_joint_priority.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_joint_simple.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_linear_expand.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_multiplexer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_scatter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_serializer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_shift_register_lut.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_split.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_split_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_split_pack2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_spliter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_switch.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_switch_simple.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_unit_converter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_data_width_converter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_demultiplexer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_deselector.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_async_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_generic_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_ra.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_ra_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_ra_read_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_ram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_read_fwtf.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_shifter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_fifo_width_convert_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_func_binary_to_graycode.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_func_graycode_to_binary.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_func_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_func_shift.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_func_unpack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_minmax.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_multiplexer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_param_update_master.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_param_update_slave.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_params_ram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_pipeline_control.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_pipeline_delay.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_pipeline_insert_ff.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_pulse_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_accumulator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_async_singleport.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_dualport.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_quad_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_simple_dualport.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ram_singleport.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_rand_gen.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_register_wishbone.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_reset.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_reverse.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ring_bus_arbiter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ring_bus_arbiter_bidirection.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ring_bus_crossbar.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ring_bus_crossbar_bidirection.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_ring_bus_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_selector.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_semaphore.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_shadow_reg_ctl.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_signal_transfer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_signal_transfer_async.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_signal_transfer_sync.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_add_syncflag.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_arbiter_bidirection.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_arbiter_crossbar.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_arbiter_ring_bus.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_arbiter_token_ring.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_combiner.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_delay.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_gate.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_id_filter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_joint.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_joint_priority.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_ring_bus_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_switch.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_token_ring_unit.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_width_convert.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly_stream_width_convert_pack.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_calc_crc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_count_leading_zeroes.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_denorm_float_mul.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_denorm_reciprocal_float.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_denorm_to_fixed.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_denorm_to_float.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_atan2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_atan2_multicycle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_divider.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_float_mul.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_float_mul_add2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_float_projective_transformation_2d.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_matrix3x4.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_matrix_divider.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_reciprocal.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_fixed_to_float.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_add.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_multiply.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_projective_transformation_2d.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_reciprocal.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_step.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_float_to_fixed.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_integer_accumulator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_integer_clz.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_integer_divider.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_integer_step.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_linear_interpolation.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_shift_pipeline.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_signed_divide_multicycle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_unsigned_alpha_blend.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_unsigned_divide_multicycle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_unsigned_multiply_multicycle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly_unsigned_sqrt_multicycle.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_adder.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_alu.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_cop0.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_dbg_comm.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_dbu.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_divider.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_gpr.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_idu.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_memdec.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_memenc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_muldiv.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_multiplier.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_shifter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_simple_top.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/mipsi/jelly_cpu_top.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_axi4_dummy_slave.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_axi4_dummy_slave_read.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_axi4_dummy_slave_write.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_axi4s_debug_monitor.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_comm_to_wishbone.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_data_logger_fifo.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_ezusbfx2_to_comm.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_i2c_slave.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly_regfile64_w1r2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_clock_counter.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_ddr_sdram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_ddr_sdram_init.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_ddr_sdram_io.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_ddr_sdram_oddr.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_ddr_sdram_out.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_extbus.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_gpio.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_i2c.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_i2c_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_interval_timer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_irc.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_irc_factor.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_pipe.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_pipe_port.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_spi.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_spi_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_sram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_uart.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_uart_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_uart_debugger.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_uart_rx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/peripheral/jelly_uart_tx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_mul_add2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_mul_add3.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_mul_add_dsp48e1.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_multiplexer16.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_multiplexer4.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_ram64x1d.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly_ram64x1d_w1r2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly_rtos_axi4l.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_bilinear_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_dvi_rx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_dvi_rx_decode.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_dvi_tx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_dvi_tx_encode.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_hdmi_rx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_hdmi_rx_decode.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_hdmi_rx_dpa.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_csi2_rx.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_csi2_rx_low_layer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_csi2_rx_raw10.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_ecc24.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_rx_lane.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_rx_lane_recv.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_mipi_rx_lane_sync.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_pattern_generator_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_serdes_10to1_7series.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_serdes_1to10_7series.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_serdes_1to10_dpa_7series.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_serdes_1to5_dpa_7series.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4_to_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4_to_axi4s_control.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4_to_axi4s_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4s_to_axi4.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4s_to_axi4_control.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4s_to_axi4_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vdma_axi4s_to_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_binarizer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_binarizer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_combiner2.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_format_regularizer.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_format_regularizer_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_gate_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_integrator_bram.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_integrator_bram_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_parameter_update.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_pwm_modulator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_pwm_modulator_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_resize_half.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_resize_half_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_resize_half_h_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_resize_half_v_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_resize_half_wb.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_rgb_to_gray.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_tbl_modulator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_tbl_modulator_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_video_trimming_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vin_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vout_axi4s.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vsync_adjust_de.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vsync_adjust_de_core.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vsync_generator.v
JELLY_VLOG_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly_vsync_generator_core.v


JELLY_SV_SOURCES  = $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_read.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_read_nd.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_read_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_write.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_write_nd.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4_write_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4s_fifo.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4s_fifo_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_axi4s_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_wishbone_address_decoder.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_wishbone_async.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_wishbone_ff.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/bus/jelly2_wishbone_simple_decoder.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_buffer_allocator.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_buffer_manager.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_dma_stream_read.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_dma_stream_write.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_dma_video_read.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/dma/jelly2_dma_video_write.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly2_texture_cache_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/gpu/jelly2_texture_sampler_2d.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_img.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_img_auto.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_img_simple.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_insert_blank.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_to_img_auto.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_axi4s_to_img_simple.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_binarizer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_binarizer_calc.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_binarizer_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_blk_buffer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_color_matrix.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_color_matrix_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_delay.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_demosaic_acpi.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_demosaic_acpi_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_demosaic_acpi_g_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_demosaic_acpi_rb_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_filter2d.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_filter2d_calc.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_filter2d_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_line_buffer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_line_moment.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_pixel_buffer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_rgb2hsv.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_selector.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_selector_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_sobel_calc.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_sobel_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_img_to_axi4s.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/image/jelly2_rgb2hsv.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_jfive_micro_controller.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_jfive_micro_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_jfive_simple_controller.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_jfive_simple_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_register_file.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_register_file_ff.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_register_file_ram.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/jfive/jelly2_register_file_ram32x1d.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_address_align_split.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_address_generator.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_address_generator_nd.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_address_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_autoclear_for_ram.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_buffer_arbiter.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_capacity_async.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_capacity_buffer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_capacity_size.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_data_ff_pack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_data_shift_register_lut.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_data_split_pack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_data_split_pack2.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_async.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_async_fwtf.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_fwtf.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_generic_fwtf.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_pack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_ram.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_read_fwtf.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_fifo_shifter.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_func_pack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_func_unpack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_multiplexer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_ram_accumulator.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_ram_dualport.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_ram_simple_dualport.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_ram_singleport.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_ram_with_autoclear.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_signal_transfer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_signal_transfer_async.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_signal_transfer_sync.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_stream_add_syncflag.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_stream_gate.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_stream_width_convert.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/library/jelly2_stream_width_convert_pack.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly2_calc_crc.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly2_mul_add_array.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/math/jelly2_mul_add_array_unit.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly2_communication_pipe.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly2_communication_pipes.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/misc/jelly2_data_logger_fifo.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/primitive/jelly2_ram32x1d.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_eventflag.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_queue.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_queue_fifo.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_queue_priority.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_semaphore.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_task.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/rtos/jelly2_rtos_timer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_mipi_csi2_rx.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_mipi_csi2_rx_raw10.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_mipi_rx_lane.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_demosaic_acpi.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_filter2d.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_format_regularizer.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_gate.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_overlay_bram.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_overlay_bram_core.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_rendezvous.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_rgb2hsv.sv
JELLY_SV_SOURCES += $(JELLY_TOP_DIR)/rtl/video/jelly2_video_sobel.sv


JELLY_RTL_SOURCES = $(JELLY_VLOG_SOURCES) $(JELLY_SV_SOURCES)

