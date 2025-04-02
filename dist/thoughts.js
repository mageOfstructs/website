class ThoughtDiv extends HTMLElement {
	constructor() {
		super();
		const template = document.getElementById("thought-div");
		const templateContent = template.content;

		const shadowRoot = this.attachShadow({ mode: "open" });
		shadowRoot.appendChild(templateContent.cloneNode(true));
		// Add styles directly to the shadow root
		const style = document.createElement("style");
		style.textContent = `
            ::slotted(a) {
                color: #84cc16 !important;
                text-decoration-line: underline !important;
            }
            ::slotted(a:hover) {
                background-color: #84cc16;
                color: #0a0a0a !important;
            }
        `;
		shadowRoot.appendChild(style);
		shadowRoot.querySelector("#content").innerHTML = "<slot></slot>";
	}
	connectedCallback() {
		this.shadowRoot.querySelector("#heading").textContent =
			this.attributes["heading"].nodeValue;
	}
}

customElements.define("thought-div", ThoughtDiv);
