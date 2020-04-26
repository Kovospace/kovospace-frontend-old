## titulny obrazok na stranke o jednotlivom projekte

class PortfolioTitleTabletUploader < BaseUploader

    create_sizes(
      sizes: {
        "1x" => [480, 10000],
        "2x" => [960, 10000],
        "3x" => [1440, 10000]
      },
      namespace: "bg_tablet"
    )

end
