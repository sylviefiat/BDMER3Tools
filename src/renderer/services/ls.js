import * as Cookies from "js-cookie";
import CryptoJS from "crypto-js";
import config from "@/config";

export default {
	get: key => (Cookies.get(key) !== undefined ? JSON.parse(CryptoJS.AES.decrypt(Cookies.get(key).toString(), config.cryptoKey).toString(CryptoJS.enc.Utf8), config.cryptoKey) : null),
	set: (key, value) => Cookies.set(key, CryptoJS.AES.encrypt(JSON.stringify(value), config.cryptoKey), { expires: 9999999999 }),
	remove: key => Cookies.remove(key)
};
