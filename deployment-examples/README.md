# Deployment – Examples

This folder contains example `docker compose` setups for running [**Picard Web**](https://github.com/aandree5/picard-web) with different deployment patterns.

## 📊 Example Comparison

| Example                 | Services Included                                                                                         | Access                                                                  |
| ----------------------- | --------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| [`basic/`](./basic)     | A minimal setup that exposes Picard Web directly on host ports.                                           | `https://localhost` or `https://<host-ip>`                                   |
| [`traefik/`](./traefik) | A reverse-proxy–enabled setup that runs Picard Web behind [Traefik](https://github.com/traefik/traefik/). | `https://<your-domain>` (must match `.env` and have a valid DNS record) |

> ℹ️ **Info:** The `traefik` example does **not** cover obtaining a valid TLS certificate. By default, Traefik will start with its built‑in self‑signed certificate. For production deployments, refer to the [Traefik documentation](https://doc.traefik.io/traefik/) to configure certificate management that best fits your environment.

## 📝 Notes & Recommendations

- **Avoid** using `latest` as an image tag, always pin to a specific version.
- Both examples are set to redirect to `HTTPS`.

## 📦 Deployment Steps

1. Rename `example.env` to `.env`.
2. Replace all the required variable sin `.env`.
3. Launch the stack with

   ```sh
   docker compose up -d
   ```

4. Access Picard Web:
   - **basic:** `https://localhost` or `https://<host-ip>`
   - **traefik:** `https://<your-domain>` (must resolve via DNS)
