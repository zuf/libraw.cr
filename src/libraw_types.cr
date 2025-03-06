require "./libraw_const"

@[Link("libraw_r")]
lib LibRawC
  struct DecoderInfoT
    decoder_name : UInt8*
    decoder_flags : UInt32
  end

  struct InternalOutputParamsT
    mix_green : UInt32
    raw_color : UInt32
    zero_is_bad : UInt32
    shrink : UInt16
    fuji_width : UInt16
  end

  alias MemoryCallback = Void*, Pointer(UInt8), Pointer(UInt8) -> Void
  alias ExifParserCallback = Void*, Int32, Int32, Int32, UInt32, Void*, Int64 -> Void
  alias DataCallback = Void*, Pointer(UInt8), Int32 -> Void
  alias ProgressCallback = Void*, Progress, Int32, Int32 -> Int32
  alias PreIdentifyCallback = Void* -> Int32
  alias PostIdentifyCallback = Void* -> Void
  alias ProcessStepCallback = Void* -> Void

  struct CallbacksT
    data_cb : DataCallback
    datacb_data : Void*

    progress_cb : ProgressCallback
    progresscb_data : Void*

    exif_cb : ExifParserCallback
    exifparser_data : Void*

    pre_identify_cb : PreIdentifyCallback
    post_identify_cb : PostIdentifyCallback

    pre_subtractblack_cb : ProcessStepCallback
    pre_scalecolors_cb : ProcessStepCallback
    pre_preinterpolate_cb : ProcessStepCallback
    pre_interpolate_cb : ProcessStepCallback
    interpolate_bayer_cb : ProcessStepCallback
    interpolate_xtrans_cb : ProcessStepCallback
    post_interpolate_cb : ProcessStepCallback
    pre_converttorgb_cb : ProcessStepCallback
    post_converttorgb_cb : ProcessStepCallback
  end

  fun default_data_callback(data : Void*, file : Pointer(UInt8), offset : Int32) : Void

  struct ProcessedImageT
    type : ImageFormats
    height : UInt16
    width : UInt16
    colors : UInt16
    bits : UInt16
    data_size : UInt32
    data : Pointer(UInt8) # unsigned char data[1];
  end

  struct IParamsT
    guard : StaticArray(UInt8, 4)
    make : StaticArray(UInt8, 64)
    model : StaticArray(UInt8, 64)
    software : StaticArray(UInt8, 64)
    normalized_make : StaticArray(UInt8, 64)
    normalized_model : StaticArray(UInt8, 64)
    maker_index : UInt32
    raw_count : UInt32
    dng_version : UInt32
    is_foveon : UInt32
    colors : Int32
    filters : UInt32
    xtrans : StaticArray(StaticArray(UInt8, 6), 6)
    xtrans_abs : StaticArray(StaticArray(UInt8, 6), 6)
    cdesc : StaticArray(UInt8, 5)
    xmplen : UInt32
    xmpdata : Pointer(UInt8)
  end

  struct RawInsetCropT
    cleft : UInt16
    ctop : UInt16
    cwidth : UInt16
    cheight : UInt16
  end

  struct ImageSizesT
    raw_height : UInt16
    raw_width : UInt16
    height : UInt16
    width : UInt16
    top_margin : UInt16
    left_margin : UInt16
    iheight : UInt16
    iwidth : UInt16
    raw_pitch : UInt32
    pixel_aspect : Float64
    flip : Int32
    mask : Int32[8][4]
    raw_aspect : UInt16
    raw_inset_crops : RawInsetCropT[2] # libraw_raw_inset_crop_t raw_inset_crops[2];
  end

  struct AreaT
    # top, left, bottom, right pixel coordinates, (0,0) is top left pixel;
    t : Int16
    l : Int16
    b : Int16
    r : Int16
  end

  struct Ph1T
    format : Int32
    key_off : Int32
    tag_21a : Int32
    t_black : Int32
    split_col : Int32
    black_col : Int32
    split_row : Int32
    black_row : Int32
    tag_210 : Float32
  end

  struct DngColorT
    parsedfields : UInt32
    illuminant : UInt16
    calibration : Float32[4][4]
    colormatrix : Float32[4][3]
    forwardmatrix : Float32[3][4]
  end

  struct DngLevelsT
    parsedfields : UInt32
    dng_cblack : StaticArray(UInt32, LIBRAW_CBLACK_SIZE) # Заменить LIBRAW_CBLACK_SIZE на фактический размер
    dng_black : UInt32
    dng_fcblack : StaticArray(Float32, LIBRAW_CBLACK_SIZE)
    dng_fblack : Float32
    dng_whitelevel : StaticArray(UInt32, 4)
    default_crop : StaticArray(UInt16, 4) # Origin and size
    user_crop : StaticArray(Float32, 4)   # top-left-bottom-right relative to default_crop
    preview_colorspace : UInt32
    analogbalance : StaticArray(Float32, 4)
    asshotneutral : StaticArray(Float32, 4)
    baseline_exposure : Float32
    linear_response_limit : Float32
  end

  struct P1ColorT
    romm_cam : Float32[9]
  end

  struct CanonMakernotesT
    color_data_ver : Int32
    color_data_sub_ver : Int32
    specular_white_level : Int32
    normal_white_level : Int32
    channel_black_level : StaticArray(Int32, 4)
    average_black_level : Int32
    multishot : StaticArray(UInt32, 4)
    metering_mode : Int16
    spot_metering_mode : Int16
    flash_metering_mode : UInt8
    flash_exposure_lock : Int16
    exposure_mode : Int16
    ae_setting : Int16
    image_stabilization : Int16
    flash_mode : Int16
    flash_activity : Int16
    flash_bits : Int16
    manual_flash_output : Int16
    flash_output : Int16
    flash_guide_number : Int16
    continuous_drive : Int16
    sensor_width : Int16
    sensor_height : Int16
    af_micro_adj_mode : Int32
    af_micro_adj_value : Float32
    makernotes_flip : Int16
    record_mode : Int16
    sraw_quality : Int16
    wbi : UInt32
    rf_lens_id : Int16
    auto_lighting_optimizer : Int32
    highlight_tone_priority : Int32

    #     /* -1 = n/a            1 = Economy
    #         2 = Normal         3 = Fine
    #         4 = RAW            5 = Superfine
    #         7 = CRAW         130 = Normal Movie, CRM LightRaw
    #       131 = CRM  StandardRaw */
    quality : Int16
    canon_log : Int32
    default_crop_absolute : AreaT
    recommended_image_area : AreaT
    left_optical_black : AreaT
    upper_optical_black : AreaT
    active_area : AreaT
    iso_gain : Int16[2]
  end

  struct HasselbladMakernotesT
    base_iso : Int32
    gain : Float64
    sensor : UInt8[8]
    sensor_unit : UInt8[64]
    host_body : UInt8[64]
    sensor_code : Int32
    sensor_sub_code : Int32
    coating_code : Int32
    uncropped : Int32
    capture_sequence_initiator : UInt8[32]
    sensor_unit_connector : UInt8[64]
    format : Int32
    n_ifd_cm : Int32[2]
    recommended_crop : Int32[2]
    mn_color_matrix : Float64[4][3]
  end

  struct FujiInfoT
    expo_mid_point_shift : Float32
    dynamic_range : UInt16
    film_mode : UInt16
    dynamic_range_setting : UInt16
    development_dynamic_range : UInt16
    auto_dynamic_range : UInt16
    d_range_priority : UInt16
    d_range_priority_auto : UInt16
    d_range_priority_fixed : UInt16
    brightness_compensation : Float32
    focus_mode : UInt16
    af_mode : UInt16
    focus_pixel : StaticArray(UInt16, 2)
    priority_settings : UInt16
    focus_settings : UInt32
    af_c_settings : UInt32
    focus_warning : UInt16
    image_stabilization : StaticArray(UInt16, 3)
    flash_mode : UInt16
    wb_preset : UInt16
    shutter_type : UInt16
    exr_mode : UInt16
    macro_field : UInt16
    rating : UInt32
    crop_mode : UInt16
    serial_signature : UInt8[13]
    sensor_id : StaticArray(UInt8, 5)
    raf_version : StaticArray(UInt8, 5)
    raf_data_generation : Int32
    raf_data_version : UInt16
    is_tsnerdts : Int32
    drive_mode : Int16
    black_level : StaticArray(UInt16, 9)
    raf_data_image_size_table : StaticArray(UInt32, 32)
    auto_bracketing : Int32
    sequence_number : Int32
    series_length : Int32
    pixel_shift_offset : StaticArray(Float32, 2)
    image_count : Int32
  end

  struct SensorHighspeedCropT
    cleft : UInt16
    ctop : UInt16
    cwidth : UInt16
    cheight : UInt16
  end

  struct NikonMakernotesT
    exposure_bracket_value : Float64
    active_d_lighting : UInt16
    shooting_mode : UInt16
    image_stabilization : StaticArray(UInt8, 7)
    vibration_reduction : UInt8
    vr_mode : UInt8
    flash_setting : StaticArray(UInt8, 13)
    flash_type : StaticArray(UInt8, 20)
    flash_exposure_compensation : StaticArray(UInt8, 4)
    external_flash_exposure_comp : StaticArray(UInt8, 4)
    flash_exposure_bracket_value : StaticArray(UInt8, 4)
    flash_mode : UInt8
    flash_exposure_compensation2 : Int8
    flash_exposure_compensation3 : Int8
    flash_exposure_compensation4 : Int8
    flash_source : UInt8
    flash_firmware : StaticArray(UInt8, 2)
    external_flash_flags : UInt8
    flash_control_commander_mode : UInt8
    flash_output_and_compensation : UInt8
    flash_focal_length : UInt8
    flash_gn_distance : UInt8
    flash_group_control_mode : StaticArray(UInt8, 4)
    flash_group_output_and_compensation : StaticArray(UInt8, 4)
    flash_color_filter : UInt8
    nef_compression : UInt16
    exposure_mode : Int32
    exposure_program : Int32
    n_m_eshots : Int32
    m_egain_on : Int32
    me_wb : StaticArray(Float64, 4)
    af_fine_tune : UInt8
    af_fine_tune_index : UInt8
    af_fine_tune_adj : Int8
    lens_data_version : UInt32
    flash_info_version : UInt32
    color_balance_version : UInt32
    key : UInt8
    nef_bit_depth : StaticArray(UInt16, 4)
    high_speed_crop_format : UInt16
    sensor_high_speed_crop : SensorHighspeedCropT
    sensor_width : UInt16
    sensor_height : UInt16
    active_d_lighting2 : UInt16
    shot_info_version : UInt32
    makernotes_flip : Int16
    roll_angle : Float64
    pitch_angle : Float64
    yaw_angle : Float64
  end

  struct OlympusMakernotesT
    camera_type2 : StaticArray(UInt8, 6)
    valid_bits : UInt16
    sensor_calibration : StaticArray(Int32, 2)
    drive_mode : StaticArray(UInt16, 5)
    color_space : UInt16
    focus_mode : StaticArray(UInt16, 2)
    auto_focus : UInt16
    af_point : UInt16
    af_areas : StaticArray(UInt32, 64)
    af_point_selected : StaticArray(Float64, 5)
    af_result : UInt16
    af_fine_tune : UInt8
    af_fine_tune_adj : StaticArray(Int16, 3)
    special_mode : StaticArray(UInt32, 3)
    zoom_step_count : UInt16
    focus_step_count : UInt16
    focus_step_infinity : UInt16
    focus_step_near : UInt16
    focus_distance : Float64
    aspect_frame : StaticArray(UInt16, 4)
    stacked_image : StaticArray(UInt32, 2)
    is_live_nd : UInt8
    live_n_dfactor : UInt32
    panorama_mode : UInt16
    panorama_frame_num : UInt16
  end

  struct PanasonicMakernotesT
    compression : UInt16
    black_level_dim : UInt16
    black_level : StaticArray(Float32, 8)
    multishot : UInt32
    gamma : Float32
    high_iso_multiplier : StaticArray(Int32, 3)
    focus_step_near : Int16
    focus_step_count : Int16
    zoom_position : UInt32
    lens_manufacturer : UInt32
  end

  struct PentaxMakernotesT
    drive_mode : StaticArray(UInt8, 4)
    focus_mode : StaticArray(UInt16, 2)
    af_point_selected : StaticArray(UInt16, 2)
    af_point_selected_area : UInt16
    af_points_in_focus_version : Int32
    af_points_in_focus : UInt32
    focus_position : UInt16
    af_adjustment : Int16
    af_point_mode : UInt8
    multi_exposure : UInt8
    quality : UInt16
  end

  struct RicohMakernotesT
    af_status : UInt16
    af_area_x_position : StaticArray(UInt32, 2)
    af_area_y_position : StaticArray(UInt32, 2)
    af_area_mode : UInt16
    sensor_width : UInt32
    sensor_height : UInt32
    cropped_image_width : UInt32
    cropped_image_height : UInt32
    wide_adapter : UInt16
    crop_mode : UInt16
    nd_filter : UInt16
    auto_bracketing : UInt16
    macro_mode : UInt16
    flash_mode : UInt16
    flash_exposure_comp : Float64
    manual_flash_output : Float64
  end

  struct SamsungMakernotesT
    image_size_full : StaticArray(UInt32, 4)
    image_size_crop : StaticArray(UInt32, 4)
    color_space : StaticArray(Int32, 2)
    key : StaticArray(UInt32, 11)
    digital_gain : Float64
    device_type : Int32
    lens_firmware : StaticArray(UInt8, 32)
  end

  struct KodakMakernotesT
    black_level_top : UInt16
    black_level_bottom : UInt16
    offset_left : Int16
    offset_top : Int16
    clip_black : UInt16
    clip_white : UInt16
    romm_cam_daylight : StaticArray(StaticArray(Float32, 3), 3)
    romm_cam_tungsten : StaticArray(StaticArray(Float32, 3), 3)
    romm_cam_fluorescent : StaticArray(StaticArray(Float32, 3), 3)
    romm_cam_flash : StaticArray(StaticArray(Float32, 3), 3)
    romm_cam_custom : StaticArray(StaticArray(Float32, 3), 3)
    romm_cam_auto : StaticArray(StaticArray(Float32, 3), 3)
    val018percent : UInt16
    val100percent : UInt16
    val170percent : UInt16
    maker_note_kodak8a : Int16
    iso_calibration_gain : Float32
    analog_iso : Float32
  end

  struct P1MakernotesT
    software : StaticArray(UInt8, 64)
    system_type : StaticArray(UInt8, 64)
    firmware_string : StaticArray(UInt8, 256)
    system_model : StaticArray(UInt8, 64)
  end

  struct SonyInfoT
    camera_type : UInt16
    sony0x9400_version : UInt8
    sony0x9400_release_mode2 : UInt8
    sony0x9400_sequence_image_number : UInt32
    sony0x9400_sequence_length1 : UInt8
    sony0x9400_sequence_file_number : UInt32
    sony0x9400_sequence_length2 : UInt8
    af_area_mode_setting : UInt8
    af_area_mode : UInt16
    flexible_spot_position : StaticArray(UInt16, 2)
    af_point_selected : UInt8
    af_point_selected_0x201e : UInt8
    n_af_points_used : Int16
    af_points_used : StaticArray(UInt8, 10)
    af_tracking : UInt8
    af_type : UInt8
    focus_location : StaticArray(UInt16, 4)
    focus_position : UInt16
    af_micro_adj_value : Int8
    af_micro_adj_on : Int8
    af_micro_adj_registered_lenses : UInt8
    variable_low_pass_filter : UInt16
    long_exposure_noise_reduction : UInt32
    high_iso_noise_reduction : UInt16
    hdr : StaticArray(UInt16, 2)
    group2010 : UInt16
    group9050 : UInt16
    real_iso_offset : UInt16
    metering_mode_offset : UInt16
    exposure_program_offset : UInt16
    release_mode2_offset : UInt16
    minolta_cam_id : UInt32
    firmware : Float32
    image_count3_offset : UInt16
    image_count3 : UInt32
    electronic_front_curtain_shutter : UInt32
    metering_mode2 : UInt16
    sony_date_time : StaticArray(UInt8, 20)
    shot_number_since_power_up : UInt32
    pixel_shift_group_prefix : UInt16
    pixel_shift_group_id : UInt32
    n_shots_in_pixel_shift_group : Int8
    num_in_pixel_shift_group : Int8
    prd_image_height : UInt16
    prd_image_width : UInt16
    prd_total_bps : UInt16
    prd_active_bps : UInt16
    prd_storage_method : UInt16
    prd_bayer_pattern : UInt16
    sony_raw_file_type : UInt16
    raw_file_type : UInt16
    raw_size_type : UInt16
    quality : UInt32
    file_format : UInt16
    meta_version : StaticArray(UInt8, 16)
  end

  struct ColordataT
    curve : UInt16[0x10000]
    cblack : UInt32[LIBRAW_CBLACK_SIZE] # LIBRAW_CBLACK_SIZE==4104
    black : UInt32
    data_maximum : UInt32
    maximum : UInt32

    # Canon (SpecularWhiteLevel)
    # Kodak (14N, 14nx, SLR/c/n, DCS720X, DCS760C, DCS760M, ProBack, ProBack645, P712, P880, P850)
    # Olympus, except:
    #	C5050Z, C5060WZ, C7070WZ, C8080WZ
    #	SP350, SP500UZ, SP510UZ, SP565UZ
    #	E-10, E-20
    #	E-300, E-330, E-400, E-410, E-420, E-450, E-500, E-510, E-520
    #	E-1, E-3
    #	XZ-1
    # Panasonic
    # Pentax
    # Sony
    # and aliases of the above
    # DNG
    linear_max : Int64[4]

    fmaximum : Float32
    fnorm : Float32
    white : UInt16[8][8]
    cam_mul : Float32[4]
    pre_mul : Float32[4]
    cmatrix : Float32[3][4]
    ccm : Float32[3][4]
    rgb_cam : Float32[3][4]
    cam_xyz : Float32[4][3]
    phase_one_data : Ph1T
    flash_used : Float32
    canon_ev : Float32
    model2 : StaticArray(UInt8, 64)
    unique_camera_model : StaticArray(UInt8, 64)
    localized_camera_model : StaticArray(UInt8, 64)
    image_unique_id : StaticArray(UInt8, 64)
    raw_data_unique_id : StaticArray(UInt8, 17)
    original_raw_file_name : StaticArray(UInt8, 64)
    profile : Void*
    profile_length : UInt32
    black_stat : StaticArray(UInt32, 8)
    dng_color : StaticArray(DngColorT, 2)
    dng_levels : DngLevelsT
    wb_coeffs : StaticArray(StaticArray(Int32, 4), 256)
    wbct_coeffs : StaticArray(StaticArray(Float32, 5), 64)
    as_shot_wb_applied : Int32
    p1_color : StaticArray(P1ColorT, 2)
    raw_bps : UInt32
    exif_color_space : Int32
  end

  struct ThumbnailT
    tformat : ThumbnailFormats
    twidth : UInt16
    theight : UInt16
    tlength : UInt32
    tcolors : Int32
    thumb : Pointer(UInt8)
  end

  struct ThumbnailItemT
    tformat : InternalThumbnailFormats
    twidth : UInt16
    theight : UInt16
    tflip : UInt16
    tlength : UInt32
    tmisc : UInt32
    toffset : Int64
  end

  struct ThumbnailListT
    thumbcount : Int32
    thumblist : StaticArray(ThumbnailItemT, LIBRAW_THUMBNAIL_MAXCOUNT)
  end

  struct GpsInfoT
    latitude : StaticArray(Float32, 3)
    longitude : StaticArray(Float32, 3)
    gpstimestamp : StaticArray(Float32, 3)
    altitude : Float32
    altref : UInt8
    latref : UInt8
    longref : UInt8
    gpsstatus : UInt8
    gpsparsed : UInt8
  end

  struct ImgotherT
    iso_speed : Float32
    shutter : Float32
    aperture : Float32
    focal_len : Float32
    timestamp : LibC::TimeT
    shot_order : UInt32
    gpsdata : StaticArray(UInt32, 32)
    parsed_gps : GpsInfoT
    desc : StaticArray(UInt8, 512)
    artist : StaticArray(UInt8, 64)
    analogbalance : StaticArray(Float32, 4)
  end

  struct AFInfoItemT
    af_info_data_tag : UInt32
    af_info_data_order : Int16
    af_info_data_version : UInt32
    af_info_data_length : UInt32
    af_info_data : Pointer(UInt8)
  end

  struct MetadataCommonT
    flash_ec : Float32
    flash_gn : Float32
    camera_temperature : Float32
    sensor_temperature : Float32
    sensor_temperature2 : Float32
    lens_temperature : Float32
    ambient_temperature : Float32
    battery_temperature : Float32
    exif_ambient_temperature : Float32
    exif_humidity : Float32
    exif_pressure : Float32
    exif_water_depth : Float32
    exif_acceleration : Float32
    exif_camera_elevation_angle : Float32
    real_iso : Float32
    exif_exposure_index : Float32
    color_space : UInt16
    firmware : StaticArray(UInt8, 128)
    exposure_calibration_shift : Float32
    afdata : StaticArray(AFInfoItemT, LIBRAW_AFDATA_MAXCOUNT)
    afcount : Int32
  end

  struct OutputParamsT
    greybox : StaticArray(UInt32, 4)
    cropbox : StaticArray(UInt32, 4)
    aber : StaticArray(Float64, 4)
    gamm : StaticArray(Float64, 6)
    user_mul : StaticArray(Float32, 4)
    bright : Float32
    threshold : Float32
    half_size : Int32
    four_color_rgb : Int32
    highlight : Int32
    use_auto_wb : Int32
    use_camera_wb : Int32
    use_camera_matrix : Int32
    output_color : Int32
    output_profile : Pointer(UInt8)
    camera_profile : Pointer(UInt8)
    bad_pixels : Pointer(UInt8)
    dark_frame : Pointer(UInt8)
    output_bps : Int32
    output_tiff : Int32
    output_flags : Int32
    user_flip : Int32
    user_qual : Int32
    user_black : Int32
    user_cblack : StaticArray(Int32, 4)
    user_sat : Int32
    med_passes : Int32
    auto_bright_thr : Float32
    adjust_maximum_thr : Float32
    no_auto_bright : Int32
    use_fuji_rotate : Int32
    green_matching : Int32
    dcb_iterations : Int32
    dcb_enhance_fl : Int32
    fbdd_noiserd : Int32
    exp_correc : Int32
    exp_shift : Float32
    exp_preser : Float32
    no_auto_scale : Int32
    no_interpolation : Int32
  end

  struct RawUnpackParamsT
    use_rawspeed : Int32
    use_dngsdk : Int32
    options : UInt32
    shot_select : UInt32
    specials : UInt32
    max_raw_memory_mb : UInt32
    sony_arw2_posterization_thr : Int32
    coolscan_nef_gamma : Float32
    p4shot_order : StaticArray(UInt8, 5)
    custom_camera_strings : Pointer(Pointer(UInt8))
  end

  struct RawdataT
    raw_alloc : Void*
    raw_image : UInt16*
    color4_image : UInt16[4]*
    color3_image : UInt16[3]*
    float_image : Float32*
    float3_image : Float32[3]*
    float4_image : Float32[4]*
    ph1_cblack : Int16[2]*
    ph1_rblack : Int16[2]*
    iparams : IParamsT
    sizes : ImageSizesT
    ioparams : InternalOutputParamsT
    color : ColordataT
  end

  struct MakernotesLensT
    lens_id : UInt64
    lens : UInt8[128]
    lens_format : UInt16
    lens_mount : UInt16
    cam_id : UInt64
    camera_format : UInt16
    camera_mount : UInt16
    body : StaticArray(UInt8, 64)
    focal_type : Int16
    lens_features_pre : StaticArray(UInt8, 16)
    lens_features_suf : StaticArray(UInt8, 16)
    min_focal : Float32
    max_focal : Float32
    max_ap4_min_focal : Float32
    max_ap4_max_focal : Float32
    min_ap4_min_focal : Float32
    min_ap4_max_focal : Float32
    max_ap : Float32
    min_ap : Float32
    cur_focal : Float32
    cur_ap : Float32
    max_ap4_cur_focal : Float32
    min_ap4_cur_focal : Float32
    min_focus_distance : Float32
    focus_range_index : Float32
    lens_f_stops : Float32
    teleconverter_id : UInt64
    teleconverter : StaticArray(UInt8, 128)
    adapter_id : UInt64
    adapter : StaticArray(UInt8, 128)
    attachment_id : UInt64
    attachment : StaticArray(UInt8, 128)
    focal_units : UInt16
    focal_length_in35mm_format : Float32
  end

  struct NikonlensT
    effective_max_ap : Float32
    lens_id_number : UInt8
    lens_f_stops : UInt8
    mcu_version : UInt8
    lens_type : UInt8
  end

  struct DnglensT
    min_focal : Float32
    max_focal : Float32
    max_ap4_min_focal : Float32
    max_ap4_max_focal : Float32
  end

  struct LensinfoT
    min_focal : Float32
    max_focal : Float32
    max_ap4_min_focal : Float32
    max_ap4_max_focal : Float32
    exif_max_ap : Float32
    lens_make : UInt8[128]
    lens : UInt8[128]
    lens_serial : UInt8[128]
    internal_lens_serial : UInt8[128]
    focal_length_in35mm_format : UInt16
    nikon : NikonlensT
    dng : DnglensT
    makernotes : MakernotesLensT
  end

  struct MakernotesT
    canon : CanonMakernotesT
    nikon : NikonMakernotesT
    hasselblad : HasselbladMakernotesT
    fuji : FujiInfoT
    olympus : OlympusMakernotesT
    sony : SonyInfoT
    kodak : KodakMakernotesT
    panasonic : PanasonicMakernotesT
    pentax : PentaxMakernotesT
    phaseone : P1MakernotesT
    ricoh : RicohMakernotesT
    samsung : SamsungMakernotesT
    common : MetadataCommonT
  end

  struct ShootinginfoT
    drive_mode : Int16
    focus_mode : Int16
    metering_mode : Int16
    af_point : Int16
    exposure_mode : Int16
    exposure_program : Int16
    image_stabilization : Int16
    body_serial : StaticArray(UInt8, 64)
    internal_body_serial : StaticArray(UInt8, 64)
  end

  struct CustomCameraT
    fsize : UInt32
    rw : UInt16
    rh : UInt16
    lm : UInt8
    tm : UInt8
    rm : UInt8
    bm : UInt8
    lf : UInt16
    cf : UInt8
    max : UInt8
    flags : UInt8
    t_make : StaticArray(UInt8, 10)
    t_model : StaticArray(UInt8, 20)
    offset : UInt16
  end

  struct DataT
    # image : (Pointer(UInt16[4]))[4] # ushort (*image)[4];
    # image : Void**
    image : UInt16[4]* # ushort (*image)[4];
    sizes : ImageSizesT
    idata : IParamsT
    lens : LensinfoT
    makernotes : MakernotesT
    shootinginfo : ShootinginfoT
    params : OutputParamsT
    rawparams : RawUnpackParamsT
    progress_flags : UInt32
    process_warnings : UInt32
    color : ColordataT
    other : ImgotherT
    thumbnail : ThumbnailT
    thumbs_list : ThumbnailListT
    rawdata : RawdataT
    parent_class : Void*
  end

  struct FujiQTable
    q_table : Int8*
    raw_bits : Int32
    total_values : Int32
    max_grad : Int32
    q_grad_mult : Int32
    q_base : Int32
  end

  struct FujiCompressedParams
    qt : FujiQTable[4]
    buf : Void*
    max_bits : Int32
    min_value : Int32
    max_value : Int32
    line_width : UInt16
  end

  struct BufferDatastream # LibRaw_buffer_datastream class stub
    vptr : Void*
    buf : UInt8*
    pos : LibC::SizeT
    size : LibC::SizeT
  end
end

struct LibRawC::BufferDatastream
  def bytes(len = size)
    raise "Buffer overread detected" if len > size
    Bytes.new(buf, len)
  end

  def bytes_from_pos(len = size - pos)
    raise "Buffer overread detected" if len > size - pos
    Bytes.new(buf + pos, len)
  end

  def gets(len)
    raise "Buffer overread detected" if len > size - pos
    String.new(buf + pos, len) # encoding: "ASCII"
  end

  def io
    io = IO::Memory.new(bytes, writeable = false)
    io.pos = pos
    io
  end
end

struct LibRawC::ThumbnailT
  def jpeg?
    tformat == ThumbnailFormats::LIBRAW_THUMBNAIL_UNKNOWN
  end

  def bytes
    Bytes.new(thumb, tlength)
  end

  # def to_s2
  #   "LibRaw::Thumbnail #{twidth}x#{tlength} length=#{tlength.humanize_bytes} format=#{format_string}} colors=#{tcolors}"
  # end

  def to_s(io : IO)
    io << "LibRaw::Thumbnail #{twidth}x#{theight} length=#{tlength.humanize_bytes} format=#{format_string} colors=#{tcolors}"
  end

  def format_string
    case tformat
    when ThumbnailFormats::LIBRAW_THUMBNAIL_UNKNOWN
      "unknown"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_JPEG
      "jpeg"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_BITMAP
      "bitmap"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_BITMAP16
      "bitmap16"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_LAYER
      "layer"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_ROLLEI
      "rollei"
    when ThumbnailFormats::LIBRAW_THUMBNAIL_H265
      "h265"
    else
      raise LibRawError.new("ERROR LibRaw: Unknkown thumbnail format: #{tformat}")
    end
  end
end
