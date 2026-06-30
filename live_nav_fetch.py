import os
import requests
import pandas as pd

# Base directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RAW_DATA = os.path.join(BASE_DIR, "data", "raw")

os.makedirs(RAW_DATA, exist_ok=True)

# AMFI Scheme Codes
schemes = {
    "hdfc_top_100_direct": "125497",
    "sbi_bluechip": "119551",
    "icici_bluechip": "120503",
    "nippon_large_cap": "118632",
    "axis_bluechip": "119092",
    "kotak_bluechip": "120841"
}

combined_data = []

print("=" * 70)
print("LIVE NAV FETCH")
print("=" * 70)

for scheme_name, scheme_code in schemes.items():

    url = f"https://api.mfapi.in/mf/{scheme_code}"

    try:
        response = requests.get(url)
        response.raise_for_status()

        data = response.json()

        nav_df = pd.DataFrame(data["data"])

        nav_df["scheme_code"] = scheme_code
        nav_df["scheme_name"] = data["meta"]["scheme_name"]

        file_path = os.path.join(
            RAW_DATA,
            f"{scheme_name}_live_nav.csv"
        )

        nav_df.to_csv(file_path, index=False)

        combined_data.append(nav_df)

        print(f"Saved: {scheme_name}_live_nav.csv")

    except Exception as e:
        print(f"Error fetching {scheme_name}: {e}")

# Save combined file
if combined_data:
    combined_df = pd.concat(combined_data, ignore_index=True)
    combined_df.to_csv(
        os.path.join(RAW_DATA, "five_key_schemes_live_nav.csv"),
        index=False
    )

    print("\nSaved: five_key_schemes_live_nav.csv")

print("\nLive NAV fetching completed.")