### МТМТ-рекомендації з усунення загроз

| № загрози | MTMT-рекомендації з усунення загроз | 
| :- | :-: |
| 1 | Ensure that authenticated ASP.NET pages incorporate UI Redressing or clickjacking defences. Ensure that only trusted origins are allowed if CORS is enabled on ASP.NET Web Applications. Mitigate against Cross-Site Request Forgery (CSRF) attacks on ASP.NET web pages. |
| 2 | Do not expose security details in error messages. Implement Default error handling page. Set Deployment Method to Retail in IIS. Use only approved symmetric block ciphers and key lengths. Use approved block cipher modes and initialization vectors for symmetric ciphers. Use approved asymmetric algorithms, key lengths, and padding. Use approved random number generators. Do not use symmetric stream ciphers. Use approved MAC/HMAC/keyed hash algorithms. Use only approved cryptographic hash functions. Verify X.509 certificates used to authenticate SSL, TLS, and DTLS connections. |
| 3 | Ensure that sensitive data displayed on the user screen is masked. |
| 4 | Applications available over HTTPS must use secure cookies. Enable HTTP Strict Transport Security (HSTS). |
| 5 | Ensure that sensitive content is not cached on the browser. |
| 6 | Ensure that auditing and logging is enforced on the application. Ensure that log rotation and separation are in place. Ensure that Audit and Log Files have Restricted Access. Ensure that User Management Events are Logged. |
| 7 | Set up session for inactivity lifetime. Implement proper logout from the application. |
| 8 | Verify X.509 certificates used to authenticate SSL, TLS, and DTLS connections. |
| 9 | Restrict access to Azure Postgres DB instances by configuring server-level firewall rules to only permit connections from selected IP addresses where possible. |
| 10 | It is recommended to rotate user account passwords (e.g. those used in connection strings) regularly, in accordance with your organizations policies. Store secrets in a secret storage solution (e.g. Azure Key Vault). |
| 11 | Do not expose security details in error messages. Implement Default error handling page. Set Deployment Method to Retail in IIS. Use only approved symmetric block ciphers and key lengths. Use approved block cipher modes and initialization vectors for symmetric ciphers. Use approved asymmetric algorithms, key lengths, and padding. Use approved random number generators. Do not use symmetric stream ciphers. Use approved MAC/HMAC/keyed hash algorithms. se only approved cryptographic hash functions. Verify X.509 certificates used to authenticate SSL, TLS, and DTLS connections. |
| 12 | Explicitly disable the autocomplete HTML attribute in sensitive forms and inputs. Perform input validation and filtering on all string type Model properties. Validate all redirects within the application are closed or done safely. Enable step up or adaptive authentication. Implement forgot password functionalities securely. Ensure that password and account policy are implemented. Implement input validation on all string type parameters accepted by Controller methods. |
| 13 | Consider using a standard authentication mechanism to authenticate to Web Application. |
| 14 | Encrypt sections of Web Apps configuration files that contain sensitive data. |
| 15 | Enable fine-grained access management to Azure Subscription using RBAC. |
| 16 | Enable fine-grained access management to Azure Subscription using RBAC. |
| 17 | Enable fine-grained access management to Azure Subscription using RBAC. Enable Azure Multi-Factor Authentication for Azure Administrators. |
