function init() {
  getQuote().then(
    (quote) => (document.getElementById("quoteC").innerHTML = quote),
  );

  const tty = document.getElementById("dateC");
  const date = new Date().toUTCString().replace(",", "");
  const match = /[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/.exec(date);
  const yearMatch = /[0-9][0-9][0-9][0-9]/.exec(date);
  // Wed, 19 Mar 2025 08:41:27 GMT
  const datestr =
    date.slice(0, yearMatch.index) + match[0] + " " + yearMatch[0];
  tty.textContent = datestr;
}

const USERNAME = "mage_of_dragons";
const INSTANCE = "mastodon.social";
const API_URL = `https://${INSTANCE}/api/v1`;

function getQuote() {
  return fetch(`${API_URL}/accounts/lookup?acct=${USERNAME}`)
    .then((resp) => {
      if (!resp.ok) throw new Error("Failed request: " + resp.status);
      return resp;
    })
    .then((body) => body.json())
    .then((data) => {
      const acc_id = data.id;
      return fetch(
        `${API_URL}/accounts/${acc_id}/statuses?exclude_replies=true&exclude_reblogs=true`,
      )
        .then((resp) => {
          if (!resp.ok) throw new Error("Failed request: " + resp.status);
          return resp;
        })
        .then((body) => body.json())
        .then((data) =>
          data.filter((status) => !status.poll && !status.in_reply_to_id),
        )
        .then((data) => {
          const randomIdx = Math.floor(Math.random() * data.length);
          console.log(data.length);
          console.log(randomIdx);
          return data[randomIdx].content;
        })
        .catch((e) => console.error(e));
    })
    .catch((e) => console.error(e));
}
