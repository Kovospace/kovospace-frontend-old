## galeria v portfoliu

class PortfolioGalleryUploader < BaseUploader

   create_sizes(
      sizes: {
        "xl_1x" => [480, 10000]
      },
      namespace: "gallery"
    )

end
