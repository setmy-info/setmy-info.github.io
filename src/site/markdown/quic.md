# QUIC

## Information

QUIC is a UDP-based transport protocol originally developed by Google and standardised by the IETF as **RFC 9000**
in May 2021. It is the underlying transport layer for **HTTP/3**, replacing TCP+TLS for HTTP communication.

### Key Features

* **0-RTT connection establishment** — resumes connections without a full handshake on repeated visits.
* **Built-in TLS 1.3** — encryption is integral to the protocol, not layered on top.
* **Multiplexed streams without head-of-line blocking** — multiple request/response streams share one connection;
  a lost packet in one stream does not block others (unlike TCP).
* **Connection migration** — a connection can survive a network change (e.g., switching from Wi-Fi to mobile) using
  a connection ID rather than a 4-tuple IP:port.
* **Improved loss recovery** — more sophisticated packet acknowledgement and retransmission than TCP.

### Comparison with TCP+TLS

| Aspect                     | TCP + TLS 1.3           | QUIC                          |
|----------------------------|-------------------------|-------------------------------|
| Handshake round trips      | 2 RTT (1 RTT with TLS)  | 1 RTT (0 RTT for resumption)  |
| Head-of-line blocking      | Yes (per connection)    | No (per stream only)          |
| Encryption                 | Layered (TLS on TCP)    | Integral                      |
| Connection migration        | No                      | Yes (connection ID-based)     |
| Kernel protocol stack      | Yes                     | User space (mostly)           |
| CPU overhead               | Low                     | Higher (user-space processing)|

HTTP/3 = HTTP semantics over QUIC. HTTP/2 = HTTP semantics over TCP+TLS. HTTP/1.1 = HTTP over TCP+TLS.

## Configuration

QUIC configuration is server-side in the web server or application stack:

### nginx (with QUIC / HTTP/3 support)

Requires nginx built with `--with-http_v3_module`:

```nginx
server {
    listen 443 quic reuseport;
    listen 443 ssl;

    ssl_certificate     /etc/nginx/certs/cert.pem;
    ssl_certificate_key /etc/nginx/certs/key.pem;
    ssl_protocols       TLSv1.3;

    add_header Alt-Svc 'h3=":443"; ma=86400';
}
```

### Caddy

Caddy enables QUIC/HTTP/3 automatically when HTTPS is configured — no extra settings required.

## Usage, tips and tricks

### Check QUIC Support with curl

```shell
# curl must be built with HTTP/3 support
curl --http3 https://example.com
curl -I --http3 https://cloudflare.com
```

### Inspect Protocol in Browser DevTools

Open Chrome DevTools → **Network** tab → **Protocol** column. A value of `h3` indicates HTTP/3 over QUIC.

### Alt-Svc Header

Servers advertise QUIC support via the `Alt-Svc` response header so browsers upgrade on subsequent requests:

```
Alt-Svc: h3=":443"; ma=86400
```

### Server Implementations

| Server / Library  | QUIC / HTTP/3 status                            |
|-------------------|-------------------------------------------------|
| nginx             | Experimental (`--with-http_v3_module`)          |
| Caddy             | Built-in, automatic                             |
| LiteSpeed / OpenLiteSpeed | Built-in                              |
| HAProxy           | Supported from 2.6+                             |
| Cloudflare        | Full QUIC support on all proxied domains        |
| quiche (Rust)     | Low-level QUIC library by Cloudflare            |
| msquic (C)        | Microsoft's cross-platform QUIC library         |

## See also

* [QUIC Working Group](https://quicwg.org/)
* [RFC 9000 — QUIC transport](https://www.rfc-editor.org/rfc/rfc9000)
* [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)
* [HTTP/3 explained](https://http3-explained.haxx.se/)
* [nginx QUIC documentation](https://nginx.org/en/docs/quic.html)
