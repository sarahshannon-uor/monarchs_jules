import cdsapi

dataset = "reanalysis-era5-single-levels"

# List of variables to loop over
variables = [
    "10m_u_component_of_wind",
    "10m_v_component_of_wind",
    "2m_dewpoint_temperature",
    "2m_temperature",
    "surface_pressure",
    "surface_solar_radiation_downwards",
    "surface_thermal_radiation_downwards",
    "snowfall",
]

def get_request(year, variable):
    request = {
        "product_type": "reanalysis",
        "variable": variable,
        "year": str(year),
        "month": [f"{m:02d}" for m in range(1, 13)],
        "day": [f"{d:02d}" for d in range(1, 32)],
        "time": [f"{h:02d}:00" for h in range(24)],
        "format": "netcdf",
        "area": [-64.95, -60.55, -65.05, -60.45],  # N, W, S, E
    }
    return request

client = cdsapi.Client()

for year in [2013]:
#for year in range(2020, 2022):
    for var in variables:
        print(f"Requesting {var} for {year}...")
        request = get_request(year, var)
        output_file = f"era5_{year}_{var}.nc"
        client.retrieve(dataset, request).download(output_file)
        print(f"Saved {output_file}")
