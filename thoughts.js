class ThoughtDiv extends HTMLElement {
  constructor() {
    super();
    const template = document.getElementById("thought-div");
    const templateContent = template.content;

    const shadowRoot = this.attachShadow({ mode: "open" });
    shadowRoot.appendChild(templateContent.cloneNode(true));
  }
  connectedCallback() {
    console.log("test");
    this.shadowRoot.getElementById("heading").textContent =
      this.attributes["heading"].nodeValue;

    this.shadowRoot.getElementById("content").textContent =
      this.attributes["desc"].nodeValue;
  }
}

customElements.define("thought-div", ThoughtDiv);
