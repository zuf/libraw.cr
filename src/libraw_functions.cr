require "./libraw_const"
require "./libraw_types"

# C Docs: https://www.libraw.org/docs/API-C.html
@[Link("libraw_r")]
lib LibRawC
  # type LibRawDataTPtr = DataT*
  alias LibRawDataTPtr = DataT*

  # Initialization and denitialization
  #
  # The function returns the pointer to the instance of libraw_data_t structure.
  # The resultant pointer should be passed as the first argument to all C API functions (except for libraw_strerror).
  # Returns NULL in case of error, pointer to the structure in all other cases.
  fun libraw_init(flags : ConstructorFlags) : LibRawDataTPtr

  # Closes libraw_data_t handler and deallocates all memory. 1
  fun libraw_close(libraw_data_t : LibRawDataTPtr)

  # Returned values
  # Functions of C API return EINVAL (see errno.h) if the null pointer was passed to them as the first argument. In all other cases, the C++ API return code is returned.

  # Data Loading from a File/Buffer
  fun libraw_open_file(libraw_data_t : LibRawDataTPtr, file : UInt8*) : LibRawC::Errors
  fun libraw_open_file_ex(libraw_data_t : LibRawDataTPtr, file : UInt8*, bigfile_size : Int64) : LibRawC::Errors
  fun libraw_open_buffer(libraw_data_t : LibRawDataTPtr, buffer : Void*, bufsize : LibC::SizeT) : LibRawC::Errors

  # fun libraw_open_bayer(libraw_data_t *lr, unsigned char *data, unsigned datalen, ushort _raw_width, ushort _raw_height, ushort _left_margin, ushort _top_margin, ushort _right_margin, ushort _bottom_margin, unsigned char procflags, unsigned char bayer_battern, unsigned unused_bits, unsigned otherflags, unsigned black_level) : Int32
  fun libraw_unpack(libraw_data_t : LibRawDataTPtr) : LibRawC::Errors
  fun libraw_unpack_thumb(libraw_data_t : LibRawDataTPtr) : LibRawC::Errors
  fun libraw_unpack_thumb_ex(libraw_data_t : LibRawDataTPtr, thumb_index : Int32) : LibRawC::Errors

  # Parameters setters/getters
  #
  # These functions provides interface to imgdata.params, .sizes and .color fields which
  # works regardless of LibRaw versions used when building calling app and the library itself.
  fun libraw_get_raw_height(lr : LibRawDataTPtr) : Int32
  fun libraw_get_raw_width(lr : LibRawDataTPtr) : Int32
  fun libraw_get_iheight(lr : LibRawDataTPtr) : Int32
  fun libraw_get_iwidth(lr : LibRawDataTPtr) : Int32
  fun libraw_get_cam_mul(lr : LibRawDataTPtr, index : Int32) : Float32
  fun libraw_get_pre_mul(lr : LibRawDataTPtr, index : Int32) : Float32
  fun libraw_get_rgb_cam(lr : LibRawDataTPtr, index1 : Int32, index2 : Int32) : Float32
  fun libraw_get_iparams(lr : LibRawDataTPtr) : IParamsT*
  fun libraw_get_lensinfo(lr : LibRawDataTPtr) : LensinfoT*
  fun libraw_get_imgother(lr : LibRawDataTPtr) : ImgotherT*
  fun libraw_get_color_maximum(lr : LibRawDataTPtr) : Int32
  fun libraw_set_user_mul(lr : LibRawDataTPtr, index : Int32, val : Float32)
  fun libraw_set_demosaic(lr : LibRawDataTPtr, value : Int32)
  fun libraw_set_adjust_maximum_thr(lr : LibRawDataTPtr, value : Float32)
  fun libraw_set_output_color(lr : LibRawDataTPtr, value : Int32)
  fun libraw_set_output_bps(lr : LibRawDataTPtr, value : Int32)
  fun libraw_set_gamma(lr : LibRawDataTPtr, index : Int32, value : Float32)
  fun libraw_set_no_auto_bright(lr : LibRawDataTPtr, value : Int32)
  fun libraw_set_bright(lr : LibRawDataTPtr, value : Float32)
  fun libraw_set_highlight(lr : LibRawDataTPtr, value : Int32)
  fun libraw_set_fbdd_noiserd(lr : LibRawDataTPtr, value : Int32)

  # Auxiliary Functions
  fun libraw_version : UInt8*
  fun libraw_versionNumber : Int32
  # bool LIBRAW_CHECK_VERSION(major,minor,patch)
  fun libraw_capabilities : UInt32
  fun libraw_cameraCount : Int32
  fun libraw_cameraList : UInt8**
  fun libraw_get_decoder_info(lr : LibRawDataTPtr, decoder_info : DecoderInfoT*) : Int32
  fun libraw_unpack_function_name(lr : LibRawDataTPtr) : UInt8*
  fun libraw_COLOR(lr : LibRawDataTPtr, row : Int32, col : Int32) : Int32
  fun libraw_subtract_black(lr : LibRawDataTPtr)
  fun libraw_recycle_datastream(lr : LibRawDataTPtr)
  fun libraw_recycle(lr : LibRawDataTPtr)
  fun libraw_strerror(errorcode : Int32) : UInt8*
  fun libraw_strprogress(ptogress : Progress) : UInt8*
  fun libraw_set_dataerror_handler(lr : LibRawDataTPtr, func : DataCallback, data : Void*)
  fun libraw_set_progress_handler(lr : LibRawDataTPtr, func : ProgressCallback, data : Void*)
  fun libraw_set_exifparser_handler(lr : LibRawDataTPtr, callback : ExifParserCallback, datap : Void*)

  # Data Postprocessing, Emulation of dcraw Behavior
  #   Setting of Parameters
  #
  #     The postprocessing parameters for the calls described below are set, just as for C++ API, via setting of fields in the libraw_output_params_t structure:
  #
  #       libraw_data_t *ptr = libraw_init(0);
  #       ptr->params.output_tiff = 1; //  output to TIFF
  #
  #     Fields of this structure are described in the documentation to libraw_output_params_t. For notes on their use, see API notes.

  #   Emulation of dcraw Behavior
  fun libraw_raw2image(lr : LibRawDataTPtr) : Int32
  fun libraw_free_image(lr : LibRawDataTPtr) : Int32
  fun libraw_adjust_sizes_info_only(lr : LibRawDataTPtr) : Int32
  fun libraw_dcraw_process(lr : LibRawDataTPtr) : Int32

  # Writing to Output Files
  fun libraw_dcraw_ppm_tiff_writer(lr : LibRawDataTPtr, filename : UInt8*) : Int32
  fun libraw_dcraw_thumb_writer(lr : LibRawDataTPtr, fname : UInt8*) : LibRawC::Errors

  # Writing processing results to memory buffer
  fun libraw_dcraw_make_mem_image(lr : LibRawDataTPtr, errcode : Int32*) : ProcessedImageT*
  fun libraw_dcraw_make_mem_thumb(lr : LibRawDataTPtr, errcode : Int32*) : ProcessedImageT*
  fun libraw_dcraw_clear_mem(processed_image_t : ProcessedImageT*)
end
