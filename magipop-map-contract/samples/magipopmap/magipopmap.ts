/**
 * @contract MagipopMap
 * @extra Author: Blink Chen
 * @extra Email: blink@magipop.xyz
 * @extra Description: Magipop Map contract
 */

const MAP_PREFIX = ByteString.fromHex("0x01");
const LOCATION_PREFIX = ByteString.fromHex("0x02");
const OWNER_KEY = ByteString.fromHex("0xFF");

/** @event */
declare function Transfer(from: Hash160 | null, to: Hash160 | null, amount: bigint, tokenId: Hash256): void;

// interface LocationState {
//     owner: Hash160;
//     mapId: string;
//     name: string;
//     description: string;
//     x: string;
//     y: string;
//     tags: string;
//     image: string;
// }

type LocationState = [Hash160, string, string, string, string, string, string, string];

/** @safe */
export function ownerOf(locationId: string) {
    const key = concat(LOCATION_PREFIX, locationId);
    const serialzied = Storage.context.get(key);
    if (serialzied) {
        const [owner] = StdLib.deserialize(serialzied) as LocationState;
        return owner;
    } else {
        return null;
    }
}

/** @safe */
export function post(locationId: string, message: string) {
    if (!checkOwner()) throw Error("Only the contract owner can post messages");
    const key = concat(LOCATION_PREFIX, locationId);
    Storage.context.put(key, message);
    return locationId;
}

/** @safe */
export function detailOf(locationId: string) {
    const key = concat(LOCATION_PREFIX, locationId);
    const serialzied = Storage.context.get(key);
    if (serialzied) {
        const [owner, mapId, name, description, x, y, tags, image] = StdLib.deserialize(serialzied) as LocationState;
        const map = new Map<string, any>();
        map.set("owner", owner);
        map.set("mapId", mapId);
        map.set("name", name);
        map.set("description", description);
        map.set("x", x);
        map.set("y", y);
        map.set("tags", tags);
        map.set("image", image);
        return map;
    } else {
        return undefined;
    }
}

export function _deploy(_data: any, update: boolean): void {
    if (update) return;
    const tx = Runtime.scriptContainer as Transaction;
    Storage.context.put(OWNER_KEY, tx.sender);
}

function checkOwner() {
    return checkWitness(Storage.context.get(OWNER_KEY)!.asHash160());
}
