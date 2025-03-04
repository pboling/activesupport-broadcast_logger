# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [2.0.4] - 2025-02-24
- COVERAGE:  97.06% -- 66/68 lines in 3 files
- BRANCH COVERAGE:  90.00% -- 9/10 branches in 3 files
- 73.68% documented
### Added
- `stone_checksums` for gem release checksums
### Changed
- upgrade `version_gem` v1.1.6
### Fixed
- Rails v5.2 compatibility
  - Define `ActiveSupport::Logger.broadcast` as a NoOp
  - Fix circular require
- Use `Kernel.load` in gemspec instead of RubyGems' monkey patched `load`

## [2.0.3] - 2024-11-22
- COVERAGE:  97.06% -- 66/68 lines in 3 files
- BRANCH COVERAGE:  90.00% -- 9/10 branches in 3 files
- 73.68% documented
### Removed
- rdoc as runtime dependency
### Changed
- upgrade activesupport-logger v2.0.3

## [2.0.2] - 2024-11-22
- COVERAGE:  97.06% -- 66/68 lines in 3 files
- BRANCH COVERAGE:  90.00% -- 9/10 branches in 3 files
- 73.68% documented
### Added
- rdoc as development dependency
### Changed
- upgrade activesupport-logger v2.0.2

## [2.0.1] - 2024-11-21
- COVERAGE:  97.06% -- 66/68 lines in 3 files
- BRANCH COVERAGE:  90.00% -- 9/10 branches in 3 files
- 73.68% documented
### Changed
- Upgraded to activesupport-logger v2.0.1
### Fixed
- Compatibility with ActiveSupport
    - Many libraries do `require "active_support"`

## [2.0.0] - 2024-11-21
- COVERAGE:  97.06% -- 66/68 lines in 3 files
- BRANCH COVERAGE:  90.00% -- 9/10 branches in 3 files
- 73.68% documented
### Added
- Initial release
