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
      a {
          color: var(--primary) !important;
          text-decoration-line: underline !important;
      }
      a:hover {
          background-color: var(--primary);
          color: #0a0a0a !important;
      }
      ul, ol {
        margin-left: 2em !important;
        list-style: unset;
      }
      blockquote {
          border-left: solid grey 3px !important;
          padding-left: 2em !important;
          font-style: italic !important;
          background-color: #111;
      }
    `;
		shadowRoot.appendChild(style);
	}
	connectedCallback() {
		const content = this.shadowRoot.querySelector("#content");
		setTimeout(() => {
			content.append(...this.childNodes);
		});
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
			const shadowRoot = this.shadowRoot
				? this.shadowRoot
				: this.attachShadow({ mode: "open" });
			const additionalStyles = document.createElement("style");
			additionalStyles.innerText = `
pre {
  line-height: 1.5em;
  padding: 1em;
}
`;
			shadowRoot.appendChild(additionalStyles);
			shadowRoot.append(...this.childNodes);
		});
	}
}

customElements.define("thought-div", ThoughtDiv);
customElements.define("thought-cb", Codeblock);
