require "../src/libraw"

raw_photo_file = "/path/to/photo.cr2"

libraw = LibRaw.new(raw_photo_file)
puts "#{String.new libraw.iparams.make.to_unsafe} #{String.new libraw.iparams.model.to_unsafe} #{String.new libraw.lensinfo.lens.to_unsafe}  | #{libraw.raw_height} x #{libraw.raw_width} ISO=#{libraw.imgother.iso_speed} S=#{libraw.imgother.shutter} A=#{libraw.imgother.aperture} T=#{Time.unix libraw.imgother.timestamp} N=#{libraw.imgother.shot_order}"

# Extract thumbnail from raw and save as separate file
libraw.unpack_thumb
puts "Thumbnail info: #{libraw.thumbnail.tformat} #{libraw.thumbnail.twidth} x #{libraw.thumbnail.theight} colors: #{libraw.thumbnail.tcolors} #{libraw.thumbnail.tlength.humanize_bytes}"

# Assume thumbnail in jpeg format (most common case).
# See also https://www.libraw.org/docs/API-datastruct-eng.html#LibRaw_thumbnail_formats
File.write "/tmp/photo_thumbnail.jpg", libraw.tumbnail_bytes

# unpack raw data
libraw.unpack
libraw.dcraw_process

# Save as uncompressed rgb data
libraw.dcraw_ppm_tiff_writer "/tmp/photo.ppm"
