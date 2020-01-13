Workarea Salesforce Esp
================================================================================

Salesforce Esp plugin for the Workarea platform. Plugin supports adding a user to a default list.


Setup and Configuration
--------------------------------------------------------------------------------
To make use of the gateway you must add the following keys to your secrets file:

    # ...
    salesforce:
      client_id: clientIDabcd....
      secret: secret.....
    # ...

You can find this information via the sales force app center.

**The following configurations are required:**

The default salesforce list ID:

    # ...
    config.salesforce.default_list = '856'
    # ...

The endpoint for generating a token endpoint:

    # ...
    config.salesforce.token_endpoint = 'https://XXXXXX.auth.marketingcloudapis.com'
    # ...


See [https://developer.salesforce.com/docs/atlas.en-us.noversion.mc-apis.meta/mc-apis/routes.htm](https://developer.salesforce.com/docs/atlas.en-us.noversion.mc-apis.meta/mc-apis/routes.htm) for Salesforce Cloud Marketing platform documentation.

**Note!** Some reference material still references ExactTarget. Exacttarget was purchased by Salesforce and can be considered the same entity.

Getting Started
--------------------------------------------------------------------------------

This gem contains a Rails engine that must be mounted onto a host Rails application.

    # ...
    gem 'workarea-salesforce_esp'
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Afterpay is released under the [Business Software License](LICENSE)
