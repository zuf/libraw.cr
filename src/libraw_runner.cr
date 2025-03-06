require "./lib/libraw"
require "./image_rgb"
require "./libraw_reader"

# # p! siz1eof(LibRawC::DataT)
# # p! sizeof(UInt16[4]*)
# # p! sizeof(LibRawC::ImageSizesT)
# # p! sizeof(LibRawC::IParamsT)

# # p! sizeof(LibRawC::LensinfoT)

# # # makernotes:
# # p! sizeof(LibRawC::MakernotesT)
# # # shootinginfo:
# # p! sizeof(LibRawC::ShootinginfoT)
# # # params:
# # p! sizeof(LibRawC::OutputParamsT)
# # # rawparams:
# # p! sizeof(LibRawC::RawUnpackParamsT)
# # # progress_flags:
# # p! sizeof(UInt32)
# # # process_warnings:
# # p! sizeof(UInt32)
# # # color:
# # p! sizeof(LibRawC::ColordataT)
# # # other:
# # p! sizeof(LibRawC::ImgotherT)
# # # thumbnail:
# # p! sizeof(LibRawC::ThumbnailT)
# # # thumbs_list:
# # p! sizeof(LibRawC::ThumbnailListT)
# # # rawdata:
# # p! sizeof(LibRawC::RawdataT)
# # # parent_class:
# # p! sizeof(Void*)

# # p! sizeof(LibRawC::MakernotesLensT)

# # puts
# # puts

# # p! sizeof(LibRawC::CanonMakernotesT)
# # p! sizeof(LibRawC::NikonMakernotesT)
# # p! sizeof(LibRawC::HasselbladMakernotesT)
# # p! sizeof(LibRawC::FujiInfoT)
# # p! sizeof(LibRawC::OlympusMakernotesT)
# # p! sizeof(LibRawC::SonyInfoT)
# # p! sizeof(LibRawC::KodakMakernotesT)
# # p! sizeof(LibRawC::PanasonicMakernotesT)
# # p! sizeof(LibRawC::PentaxMakernotesT)
# # p! sizeof(LibRawC::P1MakernotesT)
# # p! sizeof(LibRawC::RicohMakernotesT)
# # p! sizeof(LibRawC::SamsungMakernotesT)
# # p! sizeof(LibRawC::MetadataCommonT)

# # LibRawC::MakernotesT
# # LibRawC::RawdataT

# # p! LibRaw.to_s
# # p! LibRaw.version
# # p! LibRaw.version_number

# # p! LibRaw.capabilities
# # p! LibRaw.camera_count
# # # puts LibRaw.camera_list.join(", ")

# raw_file = "/home/zuf/000-test/20170325_150747_IMG_8520.CR2"

# file_content = Bytes.new File.size(raw_file)
# File.open(raw_file, "rb") do |f|
#   f.read file_content
# end

# lr = uninitialized LibRaw
# thumb_bytes = uninitialized Bytes
# et = Time.measure do
#   lr = LibRaw.new file_content
#   p! lr.unpack_function_name
#   # lr.open_file "/home/zuf/000-test/20170325_150747_IMG_8520.CR2"
#   # lr.unpack
#   lr.unpack_thumb

#   # imgdata = lr.imgdata
#   # puts "some"
#   # p! imgdata.image[0]

#   # p! lr.imgdata#.thumbnail.tlength

#   # p! imgdata.sizes
#   # p! lr.imgdata.thumbnail
#   # lr.dcraw_thumb_writer("/tmp/thumb.jpg")
#   thumb_bytes = lr.tumbnail_bytes
# end

# STDERR.puts "RAW Thumb decoded in #{et.to_f.humanize}s Max RPS: #{(1.0 / et.to_f).humanize}"

# puts lr.thumbnail
# p! thumb_bytes.size
# # p! lr.to_unsafe.value.thumbnail.tlength
# # p! lr.imgdata.thumbnail.tlength
# # thumbnail = Bytes.new(lr.thumbnail.thumb, lr.thumbnail.tlength)
# File.write "/tmp/thumb4.jpg", thumb_bytes

# lr.open_file raw_file
# lr.unpack_thumb
# lr.dcraw_thumb_writer("/tmp/thumb5.jpg")

# # fwrite(lr.imgdata.thumbnail.thumb, sizeof(char), iProcessor.imgdata.thumbnail.tlength, stdout);

# # p! lr.data_t.process_warnings

# img = ImageRGB.from_file("/home/zuf/Pictures/test/20190512_121413_IMG_4121.CR2", scaling_factor: ScalingFactor.new num: 1, denom: 2)
# img.save("/tmp/jpg_from_raw.jpg")

raw_file = "/home/zuf/Pictures/test/20190512_121413_IMG_4121.CR2"
el = Time.measure do
  reader = LibRawReader.new(raw_file)
end
p! el
# puts "unpack"
# reader.unpack!
