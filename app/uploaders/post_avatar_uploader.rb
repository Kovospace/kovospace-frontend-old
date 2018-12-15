class PostAvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

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

  # Create different versions of your uploaded files:
  version :thumb_288p do
     process resize_to_fill: [288, 216]
  end

  version :thumb_160p do
     process resize_to_fill: [160, 120]
  end

  version :title_240p do
     process resize_to_fit: [240, -1]
  end

  version :title_288p do
     process resize_to_fit: [288, -1]
  end

  version :title_320p do
     process resize_to_fit: [320, -1]
  end

  ## iPhone 4 and 4S
  ## Galaxy S3
  version :title_320p2 do
     process resize_to_fit: [640, -1]
  end

  ## Galaxy S4, S5, Note 3
  version :title_320p3 do
     process resize_to_fit: [960, -1]
  end

  version :title_360p do
     process resize_to_fit: [360, -1]
  end

  ## Google pixel
  ## HTC One
  version :title_360p3 do
     process resize_to_fit: [1080, -1]
  end

  ## Galaxy S6
  ## Google pixel XL
  version :title_360p4 do
     process resize_to_fit: [1440, -1]
  end

  ## iPhone 6, 6S, 7, 8
  version :title_375p2 do
     process resize_to_fit: [750, -1]
  end

  ## iPhone 6+, 7+, 8+
  version :title_375p3 do
     process resize_to_fit: [1125, -1]
  end
  version :title_414p3 do
     process resize_to_fit: [1242, -1]
  end

  ## windows phone
  ## galaxy ace 2
  version :title_480p do
     process resize_to_fit: [480, -1]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
     "bg.jpg" #if original_filename
  end
end
