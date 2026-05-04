#!/usr/bin/env python3
"""Build reusable LinkedIn People Search URLs for BrowserOS runs."""

import argparse
import urllib.parse

BASE_URL = "https://www.linkedin.com/search/results/people/"
RIYADH_URN = "101336206"

PRESETS = {
    "networking_riyadh": {"second_degree": True, "geo_urn": RIYADH_URN},
    "target_account_riyadh": {"second_degree": True, "geo_urn": RIYADH_URN},
    "broad_saudi_mapping": {"second_degree": False, "geo_urn": None},
    "strict_shortlist": {"second_degree": True, "geo_urn": None},
}


def build_url(query, second_degree=False, geo_urn=None, current_company_urn=None):
    params = {"keywords": query}

    if second_degree:
        params["network"] = '["S"]'

    if geo_urn:
        params["geoUrn"] = f'["{geo_urn}"]'

    if current_company_urn:
        params["currentCompany"] = f'["{current_company_urn}"]'

    query_string = urllib.parse.urlencode(params, quote_via=urllib.parse.quote)
    return f"{BASE_URL}?{query_string}"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--query",
        nargs="+",
        required=True,
        help="Search keywords. Multi-word queries do not need shell quotes.",
    )
    parser.add_argument("--preset", choices=sorted(PRESETS), help="Apply a reusable preset")
    parser.add_argument("--second-degree", action="store_true", help='Add network=["S"]')
    parser.add_argument("--riyadh", action="store_true", help=f"Add Riyadh geoUrn ({RIYADH_URN})")
    parser.add_argument("--geo-urn", help="Override location geoUrn")
    parser.add_argument("--current-company-urn", help="Add currentCompany filter by LinkedIn company URN")
    args = parser.parse_args()

    query = " ".join(args.query).replace("_", " ").strip()
    second_degree = args.second_degree
    geo_urn = args.geo_urn

    if args.preset:
        preset = PRESETS[args.preset]
        second_degree = second_degree or preset["second_degree"]
        geo_urn = geo_urn or preset["geo_urn"]

    if args.riyadh and not geo_urn:
        geo_urn = RIYADH_URN

    print(
        build_url(
            query=query,
            second_degree=second_degree,
            geo_urn=geo_urn,
            current_company_urn=args.current_company_urn,
        )
    )


if __name__ == "__main__":
    main()
