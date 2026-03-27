# Notes on DNS resolution

we are using AWS route53 to generate dns records. 
However in this project, we are using godaddy to provide the root domain url.
We have two options:

## 1. We can completely substitute godaddy's name servers for AWS's severs

* https://tutorialsdojo.com/simplifying-dns-management-how-to-transfer-your-domains-dns-from-godaddy-to-amazon-route-53/    Simplifying DNS Management: How to Transfer Your Domain’s DNS from GoDaddy to Amazon Route 53

## 2. We can create a subdomain in godaddy and use this to connect to the AWS name server

* https://www.godaddy.com/en-uk/help/add-an-ns-record-19212 
* https://repost.aws/questions/QULXL3STgjQtefiJ_q0BixXA/configure-godaddy-subdomain-to-route53 
* https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingNewSubdomain.html#UpdateDNSParentDomain



