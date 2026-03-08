# Picard Web

<div align="center">
  <img src="https://github.com/Aandree5/picard-web/blob/main/images/logo/logo_256.png?raw=true" alt="Logo" />
</div>

![Deploy Docker image](https://img.shields.io/github/actions/workflow/status/aandree5/picard-web/docker-deploy.yml?logoColor=white&label=Deploy%20Docker%20image&logo=github) 
![GitHub Release](https://img.shields.io/github/v/release/aandree5/picard-web?logoColor=white&color=teal&label=Release&logo=rocket) 
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/aandree5/picard-web?logoColor=white&color=yellow&label=Last%20commit&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cg08ZyBpZD0iU1ZHUmVwb19iZ0NhcnJpZXIiIHN0cm9rZS13aWR0aD0iMCIvPgoNPGcgaWQ9IlNWR1JlcG9fdHJhY2VyQ2FycmllciIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+Cg08ZyBpZD0iU1ZHUmVwb19pY29uQ2FycmllciI+IDxwYXRoIGQ9Ik0yMCAxMFY3QzIwIDUuODk1NDMgMTkuMTA0NiA1IDE4IDVINkM0Ljg5NTQzIDUgNCA1Ljg5NTQzIDQgN1YxME0yMCAxMFYxOUMyMCAyMC4xMDQ2IDE5LjEwNDYgMjEgMTggMjFINkM0Ljg5NTQzIDIxIDQgMjAuMTA0NiA0IDE5VjEwTTIwIDEwSDRNOCAzVjdNMTYgM1Y3IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+IDxyZWN0IHg9IjYiIHk9IjEyIiB3aWR0aD0iMyIgaGVpZ2h0PSIzIiByeD0iMC41IiBmaWxsPSIjZmZmZmZmIi8+IDxyZWN0IHg9IjEwLjUiIHk9IjEyIiB3aWR0aD0iMyIgaGVpZ2h0PSIzIiByeD0iMC41IiBmaWxsPSIjZmZmZmZmIi8+IDxyZWN0IHg9IjE1IiB5PSIxMiIgd2lkdGg9IjMiIGhlaWdodD0iMyIgcng9IjAuNSIgZmlsbD0iI2ZmZmZmZiIvPiA8L2c+Cg08L3N2Zz4=)  
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/aandree5/picard-web/latest?logoColor=white&color=orange&label=Image%20size&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMTUgMTUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3Ryb2tlPSIjZmZmZmZmIj4KDTxnIGlkPSJTVkdSZXBvX2JnQ2FycmllciIgc3Ryb2tlLXdpZHRoPSIwIi8+Cg08ZyBpZD0iU1ZHUmVwb190cmFjZXJDYXJyaWVyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KDTxnIGlkPSJTVkdSZXBvX2ljb25DYXJyaWVyIj4gPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xMS41IDMuMDQ5OTlDMTEuNzQ4NSAzLjA0OTk5IDExLjk1IDMuMjUxNDYgMTEuOTUgMy40OTk5OVY3LjQ5OTk5QzExLjk1IDcuNzQ4NTIgMTEuNzQ4NSA3Ljk0OTk5IDExLjUgNy45NDk5OUMxMS4yNTE1IDcuOTQ5OTkgMTEuMDUgNy43NDg1MiAxMS4wNSA3LjQ5OTk5VjQuNTg2MzlMNC41ODYzOCAxMS4wNUg3LjQ5OTk5QzcuNzQ4NTIgMTEuMDUgNy45NDk5OSAxMS4yNTE1IDcuOTQ5OTkgMTEuNUM3Ljk0OTk5IDExLjc0ODUgNy43NDg1MiAxMS45NSA3LjQ5OTk5IDExLjk1TDMuNDk5OTkgMTEuOTVDMy4zODA2NCAxMS45NSAzLjI2NjE4IDExLjkwMjYgMy4xODE3OSAxMS44MTgyQzMuMDk3NCAxMS43MzM4IDMuMDQ5OTkgMTEuNjE5MyAzLjA0OTk5IDExLjVMMy4wNDk5OSA3LjQ5OTk5QzMuMDQ5OTkgNy4yNTE0NiAzLjI1MTQ2IDcuMDQ5OTkgMy40OTk5OSA3LjA0OTk5QzMuNzQ4NTIgNy4wNDk5OSAzLjk0OTk5IDcuMjUxNDYgMy45NDk5OSA3LjQ5OTk5TDMuOTQ5OTkgMTAuNDEzNkwxMC40MTM2IDMuOTQ5OTlMNy40OTk5OSAzLjk0OTk5QzcuMjUxNDYgMy45NDk5OSA3LjA0OTk5IDMuNzQ4NTIgNy4wNDk5OSAzLjQ5OTk5QzcuMDQ5OTkgMy4yNTE0NiA3LjI1MTQ2IDMuMDQ5OTkgNy40OTk5OSAzLjA0OTk5TDExLjUgMy4wNDk5OVoiIGZpbGw9IiMwMDAwMDAiLz4gPC9nPgoNPC9zdmc+) 
![Docker Pulls](https://img.shields.io/docker/pulls/aandree5/picard-web?logoColor=white&color=blue&label=Docker%20pulls&logo=docker) 
![GitHub License](https://img.shields.io/github/license/aandree5/picard-web?logoColor=white&color=red&label=License&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cg08ZyBpZD0iU1ZHUmVwb19iZ0NhcnJpZXIiIHN0cm9rZS13aWR0aD0iMCIvPgoNPGcgaWQ9IlNWR1JlcG9fdHJhY2VyQ2FycmllciIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+Cg08ZyBpZD0iU1ZHUmVwb19pY29uQ2FycmllciI+IDxwYXRoIG9wYWNpdHk9IjAuMSIgZD0iTTEyIDE3SDdDNS44OTU0MyAxNyA1IDE2LjEwNDYgNSAxNVY1QzUgMy44OTU0MyA1Ljg5NTQzIDMgNyAzSDE2QzE3LjEwNDYgMyAxOCAzLjg5NTQzIDE4IDVWMTlDMTggMjAuMTA0NiAxNy4xMDQ2IDIxIDE2IDIxQzE0Ljg5NTQgMjEgMTQgMjAuMTA0NiAxNCAxOUMxNCAxNy44OTU0IDEzLjEwNDYgMTcgMTIgMTdaIiBmaWxsPSIjZmZmZmZmIi8+IDxwYXRoIGQ9Ik0xOSAzSDlWM0M3LjExNDM4IDMgNi4xNzE1NyAzIDUuNTg1NzkgMy41ODU3OUM1IDQuMTcxNTcgNSA1LjExNDM4IDUgN1YxMC41VjE3IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+IDxwYXRoIGQ9Ik0xNCAxN1YxOUMxNCAyMC4xMDQ2IDE0Ljg5NTQgMjEgMTYgMjFWMjFDMTcuMTA0NiAyMSAxOCAyMC4xMDQ2IDE4IDE5VjlWNC41QzE4IDMuNjcxNTcgMTguNjcxNiAzIDE5LjUgM1YzQzIwLjMyODQgMyAyMSAzLjY3MTU3IDIxIDQuNVY0LjVDMjEgNS4zMjg0MyAyMC4zMjg0IDYgMTkuNSA2SDE4LjUiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPHBhdGggZD0iTTE2IDIxSDVDMy44OTU0MyAyMSAzIDIwLjEwNDYgMyAxOVYxOUMzIDE3Ljg5NTQgMy44OTU0MyAxNyA1IDE3SDE0IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+IDxwYXRoIGQ9Ik05IDdIMTQiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPHBhdGggZD0iTTkgMTFIMTQiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPC9nPgoNPC9zdmc+)

**Tag your music with MusicBrainz Picard, right from your browser.**

Picard Web is a containerized, browser-accessible version of [MusicBrainz Picard](https://picard.musicbrainz.org/), the powerful open-source music tagger. No install required, just open your browser and start organizing your library.

![MusicBrainz Picard](./images/docs/Picard.png)

## ⚠️ Disclaimer

This project is not affiliated with, endorsed by, or officially supported by the [MetaBrainz Foundation](https://metabrainz.org/) or the [MusicBrainz Picard](https://picard.musicbrainz.org/) team.  
Picard Web is an independent wrapper designed to make Picard accessible via a browser-based container. All trademarks and copyrights remain the property of their respective owners.

## ⚡ Features

- **Tag with MusicBrainz** - rich metadata
- **Run in browser** - no install, works anywhere
- **ReplayGain tagging** - loudness metadata for consistent playback
- **Lyrics fetching** - synced lyrics via LRCLib
- **Clipboard support** - copy and paste between Picard and browser
- **No browser whitin a browser** - open URLs directly on the client browser
- **In-browser audio playback** - Picard’s audio streams seamlessly to the client browser
- **Dark mode available** - display app in a dark theme 

## 🧩 Image Variants

Picard Web publishes two Docker image variants:

| Variant   | Description                                                          |
| --------- | -------------------------------------------------------------------- |
| `minimal` | Contains only the core Picard application                            |
| `full`    | Includes Picard plus additional plugins and their required libraries |

## ✨ Getting Started

- ### Docker Run

Simple run command:

```bash
docker run -p 80:5000 -p 443:5443 aandree5/picard-web
```

> Then open `https://localhost` in your browser.

- ### Docker Compose

More examples are available in the [deployment-examples](./deployment-examples/README.md) folder.

```yaml
services:
  picard-web:
    image: aandree5/picard-web:latest
    container_name: picard-web
    restart: unless-stopped
    ports:
      - 80:5000
      - 443:5443
    volumes:
      - <config_dir>:/picard-web:rw
      - <music_dir>:/music:rw
```

> Replace `<config_dir>` and `<music_dir>` with the appropriate host paths.

### ‼️ Temporary Workaround for `Browser Integration`

Picard is undergoing changes to how browser integration works, particularly in how it launches webpages. Not sure if it's going to help or not, but will try to get this to work.

1. Open Picard Web
2. Go to **Options > Options... > Network**
3. **Untick** the checkbox for **Browser Integration**

This disables the integration and allows login via an auth code. However, some features—like **Lookup in Browser** may not fully work. The browser page will open, but it won’t return the match automatically.

> 📌 **Note:** For users running this locally, it's possible to forward port `8000` on docker and getting the integration to work.
>
> - Docker run:
>   `... -p 8000:8000 ...`
>
> - Docker compose:
>
> ```yaml
>
> ---
> ports:
>   - 8000:8000
> ```

## 🔌 Bundled Plugins

The `full` variant bundles several plugins to enhance tagging workflows.

- **ReplayGain 2.0** - scans audio files to calculate ReplayGain values
- **Lyrics (LRCLib)** - fetches synchronized lyrics from LRCLib
- **AcousticBrainz Tags** - highlevel classifiers and tonal/rhythm tags from the AcousticBrainz database

> These plugins come pre-installed and are enabled with their default configurations.  
> Each plugin includes configurable options available in the settings.

**ReplayGain 2.0** and **Lyrics (LRCLib)** can be applied to either an album or an individual track by right‑clicking the item, as shown below.

![ReplayGain and Lyrics plugins](./images/docs/ReplayGainLyrics.png)

## 🗂️ Bundled Tools

With the `full` variant, [Xfe](http://roland65.free.fr/xfe/) is included as a lightweight file manager, for easy navigation through the music library.  
Accessible via the applications menu.

![Applications Menu](./images/docs/ApplicationsMenu.png)

## 🌙 Dark mode

> Temporary workaround until `v3` introduces theme management.

Enable the dark UI:

- Open Picard Web and go to `Options > Options... > User Interface`.
- Set **User interface color theme** to `System`.
- Click **Make It So!** and close Picard
- It will restart automatically and open in dark mode

![Dark mode](./images/docs/DarkMode.png)

## 🏷️ Versioning & Tags

This project follows [Semantic Versioning](https://semver.org/) and uses automated releases.

## Tag Overview

| Format                               | Example        | Description                                                                   |
| ------------------------------------ | -------------- | ----------------------------------------------------------------------------- |
| `latest`                             | -              | Always the newest (`full` variant), may include breaking changes.             |
| `<variant>-v<major>`                 | `minimal-v1`   | Latest stable for a major version, of the given variant. No breaking changes. |
| `<variant>-v<major>.<minor>`         | `minimal-v1.1` | Latest patch for a minor version, of the given variant. No new featues.       |
| `<variant>-v<major>.<minor>.<patch>` | `full-v1.1.0`  | Fixed version, of the given variant, only changes if manually updated.        |

## 🛠️ Contributing

Contributions are welcome! Please follow these steps to get set up:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Aandree5/picard-web.git
   cd picard-web
   ```

2. **Install pre-commit hooks** (for license headers, linting, etc.):

   ```bash
   pip install pre-commit
   pre-commit install
   ```

3. **Follow [Conventional Commits](https://www.conventionalcommits.org/)** for commit messages:

   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `chore:` - Maintenance or tooling
   - `ci:` - CI/CD or workflow updates
   - `refactor:` - Code improvements without changing behavior
   - `revert:` - Revert a previous commit

4. **Open a Pull Request** against `main`.

## 📦 Tech Stack

- [**GUI Web Base**](https://github.com/aandree5/gui-web-base)  
  Containerized browser GUI foundation

- [**MusicBrainz Picard**](https://github.com/metabrainz/picard)  
  Music tagging software from MusicBrainz

- [**rsgain**](https://github.com/complexlogic/rsgain)  
  ReplayGain 2.0 tagging utility

- [**Xfe**](http://roland65.free.fr/xfe/)
  Lightweight file manager

## 📄 License

This project wraps [MusicBrainz Picard](https://github.com/metabrainz/picard), which is licensed under the [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).  
Picard Web itself is released under the [Apache 2.0 License](./LICENSE).

## 🙌 Credits & Dependencies

Picard Web builds on the work of several open-source projects. Huge thanks to these upstream tools and communities:

- [MusicBrainz Picard](https://github.com/metabrainz/picard) - the core music tagging engine
- [rsgain](https://github.com/complexlogic/rsgain) - ReplayGain 2.0 tagging utility
- [picard-lrclib](https://github.com/izaz4141/picard-lrclib) - lyrics plugin powered by LRCLib

## 📚 Resources

- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Apache 2.0 License](./LICENSE)
- [Security Policy](./SECURITY.md)

## ☕ Support

If you find the project useful, consider supporting its development! Your donations help cover costs and fund future improvements.

You can support through:

[![Static Badge](https://img.shields.io/badge/github-sponsor-red?logo=github&link=https%3A%2F%2Fgithub.com%2Fsponsors%2FAandree5%3Ffrequency%3Done-time%26sponsor%3DAandree5)](https://github.com/sponsors/Aandree5) 
[![Static Badge](https://img.shields.io/badge/liberapay-donate-yellow?logo=liberapay&link=https%3A%2F%2Fliberapay.com%2FAandree5)](https://liberapay.com/Aandree5/) 
[![Static Badge](https://img.shields.io/badge/stripe-donate-blue?logo=stripe)](https://donate.stripe.com/dRmcN41Z60eO3efeMCb7y00)
