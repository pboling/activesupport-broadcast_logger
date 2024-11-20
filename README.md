# Activesupport::BroadcastLogger

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/gem/v/activesupport-broadcast_logger.svg)](https://rubygems.org/gems/activesupport-broadcast_logger)
[![Downloads Today](https://img.shields.io/gem/rd/activesupport-broadcast_logger.svg)](https://github.com/pboling/activesupport-broadcast_logger)
[![CI Supported Build][🚎s-wfi]][🚎s-wf]
[![CI Unsupported Build][🚎us-wfi]][🚎us-wf]
[![CI Legacy Build][🚎lg-wfi]][🚎lg-wf]
[![CI Style Build][🚎st-wfi]][🚎st-wf]
[![CI Coverage Build][🚎cov-wfi]][🚎cov-wf]
[![CI Heads Build][🚎hd-wfi]][🚎hd-wf]

-----

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor]
[![Polar Shield][🖇polar-img]][🖇polar]
[![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi]
[![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

[🚎s-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/supported.yml
[🚎s-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/supported.yml/badge.svg
[🚎us-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/unsupported.yml
[🚎us-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/unsupported.yml/badge.svg
[🚎lg-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/legacy.yml
[🚎lg-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/legacy.yml/badge.svg
[🚎st-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/style.yml
[🚎st-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/style.yml/badge.svg
[🚎cov-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/coverage.yml
[🚎cov-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/coverage.yml/badge.svg
[🚎hd-wf]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/heads.yml
[🚎hd-wfi]: https://github.com/pboling/activesupport-broadcast_logger/actions/workflows/heads.yml/badge.svg

[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://polar.sh/embed/seeks-funding-shield.svg?org=pboling
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/buy%20me%20coffee-donate-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo

This is an **unofficial** extraction of Rails' v8 `ActiveSupport::BroadcastLogger` which has been:
* refactored ([here](https://github.com/rails/rails/pull/53093)) to only execute blocks once, and
* backported to work with Rails v5.2+ and Ruby 2.7+.

If the suite of gems this is part of is loaded in any version of Rails >= 5.2,
it will replace the logging tooling completely.

This gem is automatically depended on and configured by [activesupport-tagged_logging][activesupport-tagged_logging],
so you don't need to do anything beyond adding **that gem** to your app's Gemfile, and configuring it.

Simplified, the load order is basically:

- Standard `active_support/logger` from the Rails version loaded by your application
- Standard `active_support/broadcast_logger` from the Rails version loaded by your application (if any)
- Standard `active_support/tagged_logging` from the Rails version loaded by your application (if any)
- Enhanced [activesupport-logger][activesupport-logger] which was ripped from Rails v8.0
- Enhanced [activesupport-broadcast_logger][activesupport-broadcast_logger] which was ripped from Rails v8.0, and [this PR][pr-53093]
- Enhanced [activesupport-tagged_logging][activesupport-tagged_logging] which was ripped from Rails v8.0, and [this PR][pr-53105]

But, again, this is handled for you in [activesupport-tagged_logging][activesupport-tagged_logging].

[activesupport-logger]: https://github.com/pboling/activesupport-logger
[activesupport-broadcast_logger]: https://github.com/pboling/activesupport-broadcast_logger
[activesupport-tagged_logging]: https://github.com/pboling/activesupport-tagged_logging
[pr-53105]: https://github.com/rails/rails/pull/53105
[pr-53093]: https://github.com/rails/rails/pull/53093

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add activesupport-broadcast_logger

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install activesupport-broadcast_logger

## Usage

```ruby
require "activesupport-broadcast_logger"
```

### With `activesupport-logger` gem

[activesupport-logger][activesupport-logger]
is automatically depended on and configured by this gem,
so you don't need to do anything else.

IMPORTANT: When using this gem,
**do not `require "activesupport-logger"` in your code.**
Load order matters.

### With broadcasting support

If you want to try an experimental fix from a PR, run:

```ruby
Activesupport::FixPr53105.init
```
NOTE: The bits of logic that are unique to this gem are in the namespace `Activesupport` (sic).

See: https://github.com/rails/rails/pull/53105/files

## General Info

| Primary Namespaces | `Activesupport` && `ActiveSupport::Logger` && `Activesupport::FixPr53105`                                                                                                                                                                                                                                                                                                                                                                             |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| code triage        | [![Open Source Helpers](https://www.codetriage.com/pboling/activesupport-broadcast_logger/badges/users.svg)](https://www.codetriage.com/pboling/activesupport-broadcast_logger)                                                                                                                                                                                                                                                                       |
| documentation      | [on Github.com][homepage],  [on RubyDoc.info][documentation]                                                                                                                                                                                                                                                                                                                                                                                          |
| expert support     | [![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github)                                                                                                                                                                                                                                                 |
| `...` 💖           | [![Liberapay Patrons][⛳liberapay-img]][⛳liberapay] [![Sponsor Me][🖇sponsor-img]][🖇sponsor] [![Follow Me on LinkedIn][🖇linkedin-img]][🖇linkedin] [![Find Me on WellFound:][✌️wellfound-img]][✌️wellfound] [![Find Me on CrunchBase][💲crunchbase-img]][💲crunchbase] [![My LinkTree][🌳linktree-img]][🌳linktree] [![Follow Me on Ruby.Social][🐘ruby-mast-img]][🐘ruby-mast] [![Tweet @ Peter][🐦tweet-img]][🐦tweet] [💻][coderme] [🌏][aboutme] |

<!-- 7️⃣ spread 💖 -->
[🐦tweet-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow%20%40galtzo
[🐦tweet]: http://twitter.com/galtzo
[🚎blog]: http://www.railsbling.com/tags/activesupport-broadcast_logger/
[🚎blog-img]: https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat
[🖇linkedin]: http://www.linkedin.com/in/peterboling
[🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin
[✌️wellfound]: https://angel.co/u/peter-boling
[✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=plastic&logo=wellfound
[💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=plastic&logo=crunchbase
[🐘ruby-mast]: https://ruby.social/@galtzo
[🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=plastic&logo=mastodon&label=Ruby%20%40galtzo
[🌳linktree]: https://linktr.ee/galtzo
[🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=plastic&logo=linktree
[documentation]: https://rubydoc.info/github/pboling/activesupport-broadcast_logger
[homepage]: https://github.com/pboling/activesupport-broadcast_logger

<!-- Maintainer Contact Links -->
[aboutme]: https://about.me/peter.boling
[coderme]: https://coderwall.com/Peter%20Boling

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 then check [issues][🤝issues], or [PRs][🤝pulls],
or use the gem and think about how it could be better.

Also, see [CONTRIBUTING.md][🤝contributing].

[🤝issues]: https://github.com/pboling/activesupport-broadcast_logger/issues
[🤝pulls]: https://github.com/pboling/activesupport-broadcast_logger/pulls
[🤝contributing]: CONTRIBUTING.md

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/pboling/activesupport-broadcast_logger/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=pboling/activesupport-broadcast_logger

## 🪇 Code of Conduct

Everyone interacting in this project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct][🪇conduct].

[🪇conduct]: CODE_OF_CONDUCT.md

## 📌 Versioning

This Library adheres to [Semantic Versioning 2.0.0][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("activesupport-broadcast_logger", "~> 1.0")
```

See [CHANGELOG.md][📌changelog] for list of releases.

[comment]: <> ( 📌 VERSIONING LINKS )

[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: http://semver.org/
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].

See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

[comment]: <> ( 📄 LEGAL LINKS )

[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg

### © Copyright

* Copyright (c) David Heinemeier Hansson
* Parts original to this extraction are:
    * Copyright (c) 2024 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]

[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[bundle-group-pattern]: https://gist.github.com/pboling/4564780

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
