# Deployment – Examples

This folder contains example `docker compose` setups for running [**Picard Web**](https://github.com/aandree5/picard-web) with different deployment patterns.

## 📊 Example Comparison

| Example                 | Services Included                                                                                         | Access                                                                  |
| ----------------------- | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| [`basic/`](./basic)     | A minimal setup that exposes Picard Web directly on host ports.                                           | `https://localhost` or `https://<host-ip>`                              |
| [`traefik/`](./traefik) | A reverse-proxy–enabled setup that runs Picard Web behind [Traefik](https://github.com/traefik/traefik/). | `https://<your-domain>` (must match `.env` and have a valid DNS record) |

> ℹ️ **Info:** The `traefik` example does **not** cover obtaining a valid TLS certificate. By default, Traefik will start with its built‑in self‑signed certificate. For production deployments, refer to the [Traefik documentation](https://doc.traefik.io/traefik/) to configure certificate management that best fits your environment.

## 📝 Notes & Recommendations

- **Avoid** using `latest` as an image tag, always pin to a specific version.
- Both examples are set to redirect to `HTTPS`.

## 📦 Deployment Steps

1. Rename `example.env` to `.env`.
2. Replace all the required variables in `.env`.
3. Launch the stack with

   ```sh
   docker compose up -d
   ```

4. Access Picard Web:
   - **basic:** `https://localhost` or `https://<host-ip>`
   - **traefik:** `https://<your-domain>` (must resolve via DNS)

## 📁 Configuration Directory

Mapping `/picard-web` to a host directory (as shown in the examples) ensures:

- **Persistence** across container restarts and upgrades.
- **Ease of access** for editing configs, managing backups, and installing plugins.
- **Transparency** for troubleshooting and version control.

| Subfolder                     | Purpose                                                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `backups/`                    | Can be used to store configuration backups. When loading a backup, Picard auto-saves the current configuration. |
| `MusicBrainz/Picard/plugins/` | Drop plugins here to enable them in the Picard's settings, just like in the desktop version.                    |

> 📌 **Note:** These paths are relative to the container. When mapped to the host, they become accessible for direct editing and inspection. For example, if you mount `/picard-web` to `/opt/picard-web` on the host, your plugin path would be `/opt/picard-web/MusicBrainz/Picard/plugins/`.
