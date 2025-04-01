class ThoughtDiv extends HTMLElement {
	constructor() {
		super();
		const template = document.getElementById("thought-div");
		const templateContent = template.content;
		console.log(this.children);

		const shadowRoot = this.attachShadow({ mode: "open" });
		shadowRoot.appendChild(templateContent.cloneNode(true));
		// shadowRoot.querySelector("#heading").textContent =
		// 	this.attributes["heading"].nodeValue;
		shadowRoot.querySelector("#content").innerHTML = "<slot></slot>";
	}
	connectedCallback() {
		console.log("test");
		// this.shadowRoot.getElementById("heading").textContent =
		// 	this.attributes["heading"].nodeValue;
	}
}

customElements.define("thought-div", ThoughtDiv);
