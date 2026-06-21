# WSO2

## Information

**WSO2** is an open-source middleware platform for API management, integration, and identity/access management. It is
written in Java and runs on the JVM. WSO2 products are available as standalone deployable distributions or as a
cloud service (WSO2 Choreo).

### Main Products

| Product                  | Purpose                                                                 |
|--------------------------|-------------------------------------------------------------------------|
| WSO2 API Manager         | API gateway, developer portal, analytics, lifecycle management          |
| WSO2 Identity Server     | IAM — OAuth2, OIDC, SAML 2.0, MFA, user federation (LDAP/AD)          |
| WSO2 Micro Integrator    | ESB/integration — mediation, connectors, message transformation         |
| WSO2 Streaming Integrator| Real-time data processing and streaming analytics                       |

WSO2 API Manager and Identity Server are the most commonly deployed products. The platform can act as an OAuth2
authorization server and OIDC provider for securing microservices and SPAs.

## Installation

### Prerequisites

Java 11 or Java 17 (OpenJDK recommended) is required on all platforms.

```shell
# Rocky Linux / Fedora
sudo dnf install -y java-17-openjdk-headless
java -version
```

### Rocky Linux / Debian (ZIP install)

Download the distribution ZIP from [wso2.com](https://wso2.com/api-management/) and extract it:

```shell
# Example: API Manager
unzip wso2am-4.x.x.zip
cd wso2am-4.x.x/bin
./api-manager.sh start
# Or foreground
./api-manager.sh
```

For Identity Server:

```shell
unzip wso2is-7.x.x.zip
cd wso2is-7.x.x/bin
./wso2server.sh start
```

Default ports:
* HTTPS management console: `9443`
* HTTP offset allows running multiple instances; edit `[server]` `offset` in `deployment.toml`.

### Docker

```shell
docker pull wso2/wso2am:4.4.0
docker run -d -p 9443:9443 -p 8243:8243 -p 8280:8280 wso2/wso2am:4.4.0
```

## Configuration

Configuration is centralised in `repository/conf/deployment.toml`. Key sections:

```toml
[server]
hostname = "localhost"
offset = 0

[database.apim_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2AM_DB;..."

[keystore.tls]
file_name = "wso2carbon.jks"
password = "wso2carbon"

[transport.https.properties]
port = 9443
```

For production, replace the H2 database with PostgreSQL or MySQL and replace the default keystore with a proper TLS
certificate.

## Usage, tips and tricks

### Admin console

Browse to `https://localhost:9443/carbon` and log in with `admin` / `admin` (change immediately).

For API Manager publisher and developer portal:
* Publisher: `https://localhost:9443/publisher`
* Developer Portal: `https://localhost:9443/devportal`

### OAuth2 token flow (API Manager)

```shell
# Get a token using client credentials
curl -k -X POST https://localhost:9443/oauth2/token \
  -u "clientId:clientSecret" \
  -d "grant_type=client_credentials"

# Call an API with the token
curl -k -H "Authorization: Bearer <access_token>" \
  https://localhost:8243/myapi/1.0/resource
```

### Identity Server OIDC discovery

```shell
curl -k https://localhost:9443/oauth2/token/.well-known/openid-configuration
```

### Tips

* Use `wso2server.sh --start` (or `api-manager.sh --start`) for background daemon mode.
* Monitor logs in `repository/logs/wso2carbon.log`.
* Use the REST APIs for automated API publishing in CI/CD pipelines.
* WSO2 IS can federate users from LDAP/Active Directory via the user store configuration in `deployment.toml`.

## See also

* [WSO2 home page](https://wso2.com/)
* [WSO2 API Manager docs](https://apim.docs.wso2.com/)
* [WSO2 Identity Server docs](https://is.docs.wso2.com/)
* [WSO2 GitHub](https://github.com/wso2)
* [Keycloak](keycloak.md)
