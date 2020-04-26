## titulny obrazok na stranke o jednotlivom projekte

class PortfolioTitleMobileUploader < BaseUploader

    create_sizes(
      sizes: {
        "1x" => [240, 10000],
        "2x" => [480, 10000],
        "3x" => [720, 10000]
      },
      namespace: "bg_mobile"
    )

end
