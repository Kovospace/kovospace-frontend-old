class BaseUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::ImageOptim

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  class << self
    attr_accessor :sizes
  end

  def self.create_sizes(
      sizes: {},
      namespace: "",
      process_method: :resize_to_fill
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
      process optimize: [{
        jpegtran: true
      }]
  end

end
