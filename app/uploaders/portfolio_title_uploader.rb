class PortfolioTitleUploader < BaseUploader
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  #
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  #process :fix_exif_rotation
  #process :strip
  #process :gaussian_blur => 0.05

  #version :bg_3x do
   # process resize_to_fit: [4098, 2304]
   # process :interlace# => :plane
    #process :quality => 85
  #end

  #version :bg_2x do
   # process resize_to_fit: [2732, 1536]
    #process :interlace# => :plane
    #process :quality => 85
  #end

  version :bg do
    #process resize_to_fit: [1366, 768]
    #process :interlace# => :plane
    #process :quality => 50
    process :optimizer
  end


  # Create different versions of your uploaded files:
=begin
  create_sizes(
      sizes: {
        "1x" => [1366, 768],
        "2x" => [2732, 1536],
        "3x" => [4098, 2304]
      },
      namespace: "bg"
  )

  create_sizes(
      sizes: {
        "1x" => [320, 320],
        "2x" => [640, 640],
        "3x" => [960, 960]
      },
      namespace: "thumb"
  )
=end
  #def filename
    # "bg.jpg" if original_filename
  #end

end
