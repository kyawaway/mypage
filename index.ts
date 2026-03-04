type ElmPagesInit = {
  load: (elmLoaded: Promise<unknown>) => Promise<void>;
  flags: unknown;
};

function addStylesheet(href: string) {
  const link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = href;
  document.head.appendChild(link);
}

const config: ElmPagesInit = {
  load: async function (elmLoaded) {
    // Load Font Awesome
    addStylesheet(
      "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    );
    // Load Google Fonts (Noto Sans JP)
    addStylesheet(
      "https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;600;700&display=swap"
    );

    const app = await elmLoaded;
    console.log("App loaded", app);
  },
  flags: function () {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};

export default config;
