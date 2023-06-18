<!-- This is identity provider that will help github action to be validated against aws and perform some actions on aws -->

1 Go to Iam services
2 Click on Identity providers and select open id connect
3 For Provider url enter https://token.actions.githubusercontent.com and for Audience enter sts.amazonaws.com. Got it from link https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services where you can read more about it.
4 Click on `Get thumbprint` and then click `Add provider`

NOW ASSIGN ROLE TO THE PROVIDER
1 Create new role and give a name to the role.
2 Now use the arn for this ROLE in github actions
So now this created identity provider will be able to do those things on aws on behalf of github
