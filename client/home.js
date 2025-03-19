function init() {
	const tty = document.getElementById("tty");
	const date = new Date().toUTCString().replace(",", "");
	const match = /[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/.exec(date);
	const yearMatch = /[0-9][0-9][0-9][0-9]/.exec(date);
	// Wed, 19 Mar 2025 08:41:27 GMT
	const datestr =
		date.slice(0, yearMatch.index) + match[0] + " " + yearMatch[0];
	tty.textContent = tty.textContent.replace("date", datestr);
}
