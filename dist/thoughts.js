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
      ::slotted(blockquote) {
          border-left: solid grey 3px !important;
          padding-left: 2em !important;
          font-style: italic !important;
          background-color: #111;
      }
      ::slotted(iframe) {
          width: 100%;
          height: auto;
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

class Codeblock extends HTMLElement {
	constructor() {
		super();
	}
	connectedCallback() {
		setTimeout(() => {
			const shadowRoot = this.attachShadow({ mode: "open" });
			shadowRoot.append(...this.childNodes);
		});
	}
}

customElements.define("thought-div", ThoughtDiv);
customElements.define("thought-cb", Codeblock);
