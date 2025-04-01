class ProjectDiv extends HTMLElement {
  constructor() {
    super();
    const template = document.getElementById("project-div");
    const templateContent = template.content;

    const shadowRoot = this.attachShadow({ mode: "open" });
    shadowRoot.appendChild(templateContent.cloneNode(true));
  }
  connectedCallback() {
    this.shadowRoot.getElementById("project-heading").textContent =
      this.attributes["heading"].nodeValue;

    this.shadowRoot.getElementById("project-desc").textContent =
      this.attributes["desc"].nodeValue;

    const linkEl = this.shadowRoot.getElementById("project-link");
    linkEl.textContent = this.attributes["link"]
      ? this.attributes["link"].nodeValue
      : "Link";
    if (this.attributes.href) {
      linkEl.href = this.attributes["href"].nodeValue;
    }
  }
}

customElements.define("project-div", ProjectDiv);
