import json
import boto3
from datetime import datetime

# ------------- Sample Hierarchy Definitions for MH -------------

states = {
    #"TS": "Telangana",
    #"AP": "Andhra Pradesh",
    #"KA": "Karnataka",
    "MH": "Maharashtra"
}

districts = {
#    "TS": {
#        "HYD": "Hyderabad",
#        "RRD": "Ranga Reddy",
#        "ADL": "Adilabad"
#    },
#    "AP": {
#        "VSP": "Visakhapatnam",
#        "CTR": "Chittoor"
#    },
#    "KA": {
#        "BLR": "Bengaluru",
#        "MYS": "Mysuru"
#    },
    "MH": {
        "PUN": "Pune"
        # "NGP": "Nagpur"
    }
}

mandals = {
    # "ADL": {
    #     "ADLU": "Adilabad Urban",
    #     "BELA": "Bela",
    #     "BOAT": "Boath"
    # },
    # "RRD": {
    #     "GACH": "Gachibowli",
    #     "SHAM": "Shamshabad"
    # },
    # "HYD": {
    #     "SHAI": "Shaikpet",
    #     "MUSH": "Musheerabad"
    # },
    # "VSP": {
    #     "GAJU": "Gajuwaka",
    #     "MALK": "Malkapuram"
    # },
    # "CTR": {
    #     "TIRU": "Tirupati Rural",
    #     "MADA": "Madanapalle"
    # },
    # "BLR": {
    #     "RAJA": "Rajajinagar",
    #     "YELA": "Yelahanka"
    # },
    # "MYS": {
    #     "NANJ": "Nanjangud",
    #     "TNAR": "T. Narasipur"
    # },
    "PUN": {
        "HAV": "Haveli",
        "MUL": "Mulshi"
    }
    # "NGP": {
    #     "KATO": "Katol",
    #     "KALM": "Kalmeshwar"
    # }
}

# Villages: mandal_code -> {village_code: village_name}
villages = {
    "HAV": {
        "WAG": "Wagholi",
        "KHA": "Kharadi"
    }
    # "Mulshi": {
    #     "PAU": "Paud",
    #     "PIR": "Pirangut"
    # },
    # "Katol": {
    #     "NAR": "Narkhed",
    #     "KAL": "Kalameshwar"
    # },
    # "Kalmeshwar": {
    #     "KON": "Kondhali",
    #     "MOH": "Mohpa"
    # }
}

# Habitations: village_code -> {hab_code: hab_name}
habitations = {
    "WAG": {
        "WAG1": "Wagholi North",
        "WAG2": "Wagholi South"
     }
    # "KHA": {
    #     "KHA1": "Kharadi East",
    #     "KHA2": "Kharadi West"
    # }
    # "PAU": {
    #     "PAU1": "Paud Gaon",
    #     "PAU2": "Paud Mala"
    # },
    # "PIR": {
    #     "PIR1": "Pirangut Bk",
    #     "PIR2": "Pirangut Kh"
    # },
    # "NAR": {
    #     "NAR1": "Narkhed Rural",
    #     "NAR2": "Narkhed Urban"
    # },
    # "KAL": {
    #     "KAL1": "Kalameshwar 1",
    #     "KAL2": "Kalameshwar 2"
    # },
    # "KON": {
    #     "KON1": "Kondhali A",
    #     "KON2": "Kondhali B"
    # },
    # "MOH": {
    #     "MOH1": "Mohpa Old",
    #     "MOH2": "Mohpa New"
    # }
}

# ------------- Item Generators -------------


def now():
    return "{}Z".format(datetime.utcnow().isoformat())


def make_item(pk, sk, type, name, code, parent_id, level, ancestry):
    return {
        "pk": {"S": pk},
        "sk": {"S": sk},
        "region_type": {"S": type},
        "region_name": {"S": name},
        "region_display_name": {"S": f"{name} {type}"},
        "region_code": {"S": code},
        "parent_id": {"S": parent_id},
        "region_level": {"N": str(level)},
        "ancestry": {"L": [{"S": a} for a in ancestry]},
        "ancestry_path": {"S": "/".join(ancestry)},
        "created_at": {"S": now()},
        "updated_at": {"S": now()},
        "created_by": {"S": "system"},
        "updated_by": {"S": "system"}
    }

# ------------- Generate All Items -------------


def generate_all_items():
    items = []

    for state_code, state_name in states.items():
        ancestry = [state_code]
        items.append(make_item(
            f"REGION#{state_code}",
            f"STATE#{state_code}",
            "State",
            state_name,
            state_code,
            "",
            1,
            ancestry
        ))

        for dist_code, dist_name in districts.get(state_code, {}).items():
            ancestry = [state_code, dist_code]
            items.append(make_item(
                f"REGION#{state_code}",
                f"DISTRICT#{dist_code}",
                "District",
                dist_name,
                dist_code,
                state_code,
                2,
                ancestry
            ))

            # for mandal_name in mandals.get(dist_code, []):
            for mandal_code, mandal_name in mandals.get(dist_code, {}).items():
                # Use mandal_name as code if it matches the key in villages
                # mandal_code = mandal_name if mandal_name in villages else "".join(w[0] for w in mandal_name.upper().split())
                ancestry = [state_code, dist_code, mandal_code]
                items.append(make_item(
                    f"REGION#{state_code}",
                    f"MANDAL#{mandal_code}",
                    "Mandal",
                    mandal_name,
                    mandal_code,
                    dist_code,
                    3,
                    ancestry
                ))

                for village_code, village_name in villages.get(mandal_code, {}).items():
                    ancestry = [state_code, dist_code, mandal_code, village_code]
                    items.append(make_item(
                        f"REGION#{state_code}",
                        f"VILLAGE#{village_code}",
                        "Village",
                        village_name,
                        village_code,
                        mandal_code,
                        4,
                        ancestry
                    ))

                    for hab_code, hab_name in habitations.get(village_code, {}).items():
                        ancestry = [state_code, dist_code, mandal_code, village_code, hab_code]
                        items.append(make_item(
                            f"REGION#{state_code}",
                            f"HABITATION#{hab_code}",
                            "Habitation",
                            hab_name,
                            hab_code,
                            village_code,
                            5,
                            ancestry
                        ))
    return items


# ------------- Export to JSON -------------


def export_to_json_file(filename="geo_data.json"):
    items = generate_all_items()
    with open(filename, "w") as f:
        json.dump(items, f, indent=2)
    print(f"✅ Exported {len(items)} items to {filename}")


# ------------- Optional: Upload to DynamoDB -------------


def upload_to_dynamodb(filename, table_name="v_regions", region="ap-south-2"):
    dynamodb = boto3.resource("dynamodb", region_name=region)
    table = dynamodb.Table(table_name)

    with open(filename) as f:
        raw_items = json.load(f)

    def simplify(item):
        out = {}
        for k, v in item.items():
            if 'S' in v:
                out[k] = v['S']
            elif 'N' in v:
                out[k] = int(v['N'])
            elif 'L' in v:
                out[k] = [x['S'] for x in v['L']]
        return out

    with table.batch_writer(overwrite_by_pkeys=["pk", "sk"]) as batch:
        for item in raw_items:
            batch.put_item(Item=simplify(item))

    print(f"✅ Uploaded {len(raw_items)} items to DynamoDB table '{table_name}'")


# ------------- Main -------------


if __name__ == "__main__":
    export_to_json_file("geo_data.json")
    # Uncomment the next line to upload to DynamoDB:
    upload_to_dynamodb("geo_data.json")
