function init() {
	if (!window.location.search.includes("skip")) loadLog();
}

function loadLog() {
	const req = new XMLHttpRequest();
	req.open("GET", `${window.location.hostname}/log`);
	req.addEventListener("load", handleLogLoaded);
	req.send();
}

let glob_text_off = 0;

function getLine(str, off) {
	if (!off) {
		off = glob_text_off;
		glob_text_off = str.indexOf("\n", off) + 1;
	}
	if (glob_text_off === 0) return "";
	return str.substring(off, str.indexOf("\n", off));
}

let begin = window.performance.now();
function parseLine(line) {
	const ret = document.createElement("p");
	ret.className = "font-mono text-stone-50";
	let matches = /OK/.exec(line);
	let last_stop = 0;
	if (matches) {
		ret.appendChild(
			document.createTextNode(line.substring(last_stop, matches.index)),
		);
		const tmp = document.createElement("span");
		tmp.textContent = "OK";
		tmp.className = "text-green-600 font-bold";
		ret.appendChild(tmp);
		last_stop = matches.index + 2;
	}

	if ((matches = /FAILED/.exec(line))) {
		ret.appendChild(
			document.createTextNode(line.substring(last_stop, matches.index)),
		);
		const tmp = document.createElement("span");
		tmp.textContent = "FAILED";
		tmp.className = "text-red-600 font-bold";
		ret.appendChild(tmp);
		last_stop = matches.index + tmp.textContent.length;
	}

	if ((matches = /\<time\>/.exec(line))) {
		ret.appendChild(
			document.createTextNode(line.substring(last_stop, matches.index)),
		);
		const tmp = document.createElement("span");
		tmp.textContent = (
			window.performance.now() / 1000 -
			begin / 1000
		).toPrecision(6);
		// tmp.className = "text-red-600 font-bold";
		ret.appendChild(tmp);
		last_stop = matches.index + 6;
	}

	if ((matches = /\(.*\)\*.*/.exec(line))) {
		ret.appendChild(
			document.createTextNode(line.substring(last_stop, matches.index)),
		);
		const tmp = document.createElement("span");
		tmp.textContent = matches[0].substring(matches[0].indexOf("*") + 1);
		tmp.className = matches[0].substring(1, matches[0].indexOf(")"));
		ret.appendChild(tmp);
		last_stop = matches.index + matches[0].length;
	}

	ret.appendChild(document.createTextNode(line.substring(last_stop)));
	return ret;
}

async function handleLogLoaded() {
	const xhr = this;
	console.log(xhr.textContent);
	const container = document.getElementById("logContainer");
	container.innerHTML = "";
	begin = window.performance.now();
	do {
		const line = getLine(xhr.response);
		container.appendChild(parseLine(line));
		await new Promise((r) => setTimeout(r, 50));
	} while (glob_text_off !== 0);
	console.log("finish");
	window.location.href = "home.html";
}
