# Developer should be able to log in once in into one environment and start working

Can be many times in day (login time out).

SSO.

Examples:

* Some tools need different credentials, profiles (maven, AWS, ) for login to use them at development time. Developing
  on stage, then should for other software parts login to other environments. Flow engine at one AWS profile, DB in
  another, separate SSO logins needed.
* Looks like environments are not strongly separated and are cross used, therefore need special logins.
