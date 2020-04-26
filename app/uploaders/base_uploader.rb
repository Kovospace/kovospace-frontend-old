class BaseUploader < CarrierWave::Uploader::Base

  #include CarrierWave::RMagick
  #include CarrierWave::ImageOptim
  include CarrierWave::MiniMagick

  require 'mimemagic'
  require 'rack/mime'

  class << self
    attr_accessor :sizes
    attr_accessor :original_width
    attr_accessor :original_height
  end

  storage :file

  #process :store_dimensions
  #process :calculate_retina_sizes_from_source

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename
      extenstion = File.extname(original_filename)
      return "orig#{extenstion}"
    end
  end

  def self.create_sizes(
      sizes: {},
      namespace: "",
      process_method: :resize_to_limit
      )

      meno = namespace.blank? ? "sizes" : "#{namespace.to_s}_sizes"
      instance_variable_set("@sizes", {}) if @sizes.nil?
      @sizes[meno] = sizes.sort.reverse
      define_method(meno) { return self.class.sizes[meno] }

      @sizes[meno].each_with_index do |(size, v), index|
        if index == 0
          version "#{meno.singularize}_#{size.to_s}" do
            work_on(process_method, v[0], v[1])
          end
        else
          version(
            "#{meno.singularize}_#{size.to_s}",
            from_version: "#{meno.singularize}_#{(@sizes[meno][0])[0].to_s}".to_sym
          ) do
            work_on(process_method, v[0], v[1])
          end
        end
      end
  end

  private

  def self.work_on(meth, x, y)
      process meth => [x, y]
      process :optimizer
      def full_filename(for_file)
        if (super(for_file) == filename)
          return filename
        else
          rgx = Regexp.new("_#{filename}$")
          return super(for_file).sub(rgx, '.jpg')
        end
      end
      #process optimize: [
      #  { jpegoptim: true }
      #]
      #process optimize: [
      #  { jpegtran: true }
      #]
  end

  def store_dimensions
    if file && model
      @original_width, @original_height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
    #Rails.logger.info "----------------------"
   # Rails.logger.info @original_width
    #Rails.logger.info "----------------------"
    #Rails.logger.info "--------------------------------"
    #Rails.logger.info a
    #Rails.logger.info "-----------------------------"
  end

  def self.divide_and_round_to_even(num, divider)
    tempres = num.to_f/divider
    return tempres.floor.even? ? tempres.floor : tempres.ceil
  end

end
