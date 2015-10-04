# 2.0.0

Sun, 4 Oct 2015 19:46:34 +0200 3a42da2 Sergio Jimenez doc(readme): Added info for lxc_cgroups.
Sun, 4 Oct 2015 19:06:25 +0200 3244306 Sergio Jimenez fix(acceptance): Install stdlib.
Sun, 4 Oct 2015 18:55:08 +0200 60a2062 Sergio Jimenez fix(test): Unit test for cgroups.
Sun, 4 Oct 2015 18:42:42 +0200 10fa9a3 Sergio Jimenez cleanup: Precise support leftovers.
Sun, 4 Oct 2015 18:39:48 +0200 5e78241 Sergio Jimenez fix(cgroups): Fixed, basic cgroups support.
Sun, 4 Oct 2015 12:05:29 +0200 2a28542 Sergio Jimenez feat(platform): Removed Precise support.
Sun, 4 Oct 2015 11:22:07 +0200 d1d7f76 Sergio Jimenez feat(repo): ignore log directory.
Sat, 3 Oct 2015 23:36:17 +0200 55a9bf4 Sergio Jimenez feat(travis): Upgrade ruby 2.0.0 to 2.1
Sat, 3 Oct 2015 23:32:44 +0200 1bd37a5 Sergio Jimenez fix(travis): Needs ruby-lxc.
Sat, 3 Oct 2015 23:28:33 +0200 e1ff7b0 Sergio Jimenez feat(bundler): Reorganized gems.
Sat, 3 Oct 2015 23:12:12 +0200 ae5c140 Sergio Jimenez fix(test): Unit test.
Sat, 3 Oct 2015 20:17:16 +0200 a6fd1ec Sergio Jimenez no version for lxc
Sat, 3 Oct 2015 20:15:23 +0200 c345a22 Sergio Jimenez Better order
Sat, 3 Oct 2015 20:11:55 +0200 1027788 Sergio Jimenez And now?
Sat, 3 Oct 2015 20:08:59 +0200 3602513 Sergio Jimenez fix(travis): is it fixed yet?
Sat, 3 Oct 2015 20:01:28 +0200 3411ef1 Sergio Jimenez feat(test): Always apt-get update.
Sat, 3 Oct 2015 20:00:48 +0200 a00d1bb Sergio Jimenez feat(ruby): Upgrade deps.
Sat, 3 Oct 2015 20:00:01 +0200 815bc8d Sergio Jimenez feat(ruby): Updated Ruby version.
Sat, 3 Oct 2015 12:42:04 +0200 46421ce Sergio Jimenez Merge pull request #14 from fadenb/veth_config
Sat, 3 Oct 2015 12:40:08 +0200 ea152df Sergio Jimenez Merge pull request #13 from fadenb/cgmanager
Sat, 3 Oct 2015 12:38:55 +0200 8e6f656 Sergio Jimenez Merge pull request #12 from fadenb/lxc_ruby_bindings_gem_deps
Tue, 29 Sep 2015 13:09:39 +0200 e86522d Tristan Helmich Add new parameter to readme
Tue, 29 Sep 2015 12:58:56 +0200 c60c232 Tristan Helmich Allow configuration of veth pairs
Tue, 1 Sep 2015 16:19:51 +0200 f5e955e Tristan Helmich Manage cgmanager service
Tue, 25 Aug 2015 15:25:14 +0200 8e6f656 Tristan Helmich Update documentation for new parameter
Tue, 25 Aug 2015 15:10:23 +0200 7933442 Tristan Helmich Allow lxc_ruby_bindings_gem_deps to be overridden
Sat, 13 Jun 2015 22:24:51 +0200 063b917 Sergio Jimenez Merge pull request #8 from luxflux/fix-deprecation-warnings
Sat, 13 Jun 2015 21:27:22 +0200 3ae1dec Raffael Schmid another try on updating stdlib
Wed, 10 Jun 2015 22:53:00 +0200 91b54ac Sergio Jimenez Merge pull request #7 from luxflux/patch-2
Fri, 5 Jun 2015 21:32:56 +0200 3b4daf2 Raffael Schmid newer stdlib dependency to have support for assert_private
Fri, 5 Jun 2015 21:14:02 +0200 7f26995 Raffael Schmid use assert_private instead of deprecated private
Fri, 5 Jun 2015 21:10:10 +0200 91b54ac Raffael Schmid fix tests...?
Wed, 3 Jun 2015 17:27:14 +0200 21024ae Raffael Schmid Remove workaround for handling `ipv4.gateway`
Tue, 2 Jun 2015 15:57:40 +0200 5610101 Sergio Jimenez Merge pull request #6 from luxflux/patch-1
Thu, 28 May 2015 15:42:14 +0200 87488ac Raffael Schmid Fix example in README
Sun, 15 Mar 2015 23:35:36 +0100 ec16d0c Sergio Jimenez Added cgroups provider.
Sun, 15 Mar 2015 23:33:58 +0100 5a0469b Sergio Jimenez Added container parameter
Sun, 15 Mar 2015 18:49:10 +0100 281b2bd Sergio Jimenez Fixed license name on metadata
Sun, 15 Mar 2015 18:44:27 +0100 7cae008 Sergio Jimenez Added new type lxc_cgroups
Sat, 14 Mar 2015 23:33:41 +0100 7d7519b Sergio Jimenez Fixed forge complains about tags
Sat, 14 Mar 2015 23:11:59 +0100 2a0862d Sergio Jimenez Fixed Changelog

# 1.0.0

Sat, 14 Mar 2015 22:55:39 +0100 b6e86b2 Sergio Jimenez Updated changelog
Thu, 1 Jan 2015 01:32:48 +0100 2984d7e Sergio Jimenez :fireworks: Happy 2015!
Tue, 30 Dec 2014 15:37:16 +0100 07ee051 Sergio Jimenez Updated metadata.json.
Tue, 30 Dec 2014 15:37:02 +0100 a628076 Sergio Jimenez Updated README
Sun, 28 Dec 2014 13:06:25 +0100 61d50d1 Sergio Jimenez More tests.
Sun, 28 Dec 2014 13:03:46 +0100 8aeefe9 Sergio Jimenez Refactored lxc_interface type.
Sun, 28 Dec 2014 13:03:13 +0100 af47bab Sergio Jimenez Added value validation to timeout and template params
Sun, 28 Dec 2014 13:00:55 +0100 f751d65 Sergio Jimenez Made #define_container private
Sun, 28 Dec 2014 12:58:50 +0100 3d3eb20 Sergio Jimenez Added tests for setters.
Sun, 28 Dec 2014 12:56:01 +0100 e2a8d97 Sergio Jimenez Refactored lxc provider.
Fri, 26 Dec 2014 23:18:42 +0100 65ed999 Sergio Jimenez Moved container instantiation to its own private method.
Fri, 26 Dec 2014 22:36:24 +0100 358ebeb Sergio Jimenez More acceptance tests
Fri, 26 Dec 2014 18:46:35 +0100 54b6861 Sergio Jimenez Added and reorganized rspec-puppet tests
Fri, 26 Dec 2014 17:48:49 +0100 eb5d137 Sergio Jimenez Switched to stdlib private() function
Fri, 26 Dec 2014 17:36:31 +0100 c5ad064 Sergio Jimenez Removed restart param from lxc resource
Fri, 26 Dec 2014 17:28:53 +0100 ee081ee Sergio Jimenez make template default to ubuntu
Fri, 26 Dec 2014 17:27:50 +0100 54af41f Sergio Jimenez Added/improved headers.
Fri, 26 Dec 2014 16:45:05 +0100 52885c7 Sergio Jimenez More class documentation
Fri, 26 Dec 2014 16:44:33 +0100 36de1f3 Sergio Jimenez booleans as symbols, consistency
Fri, 26 Dec 2014 01:27:08 +0100 d6a1753 Sergio Jimenez Added ipv4_gateway to lxc_interface
Fri, 26 Dec 2014 01:17:43 +0100 7deaa07 Sergio Jimenez Added ipv4_gateway property
Thu, 25 Dec 2014 20:10:43 +0100 67ed1b2 Sergio Jimenez Reverted addition of Ruby 1.8.7 to Travis
Thu, 25 Dec 2014 20:08:12 +0100 199e95d Sergio Jimenez Added 1.8.7 to Travis matrix
Thu, 25 Dec 2014 20:03:39 +0100 67ed1b2 Sergio Jimenez Fix for Ruby 1.8.
Thu, 25 Dec 2014 20:01:48 +0100 8013992 Sergio Jimenez Execute Puppet 3 times on precise.
Thu, 25 Dec 2014 20:00:15 +0100 4883fcc Sergio Jimenez Use puppetlabs precise box with puppet included.
Thu, 25 Dec 2014 16:19:00 +0100 3cb1e9d Sergio Jimenez Converted subclasses to private.
Mon, 22 Dec 2014 19:26:08 +0100 32072d0 Sergio Jimenez Switched vagrant image with puppet included
Mon, 22 Dec 2014 19:23:08 +0100 fe972af Sergio Jimenez Added class lxc::networking::containers.
Sun, 21 Dec 2014 23:30:10 +0100 0980e42 Sergio Jimenez Updated README
Sun, 21 Dec 2014 23:29:50 +0100 c155357 Sergio Jimenez Test autostart value
Sun, 21 Dec 2014 23:26:26 +0100 9d5f1dd Sergio Jimenez Finished autostart and related settings.
Sat, 20 Dec 2014 22:42:59 +0100 492910a Sergio Jimenez Added autostart features to lxc provider.
Sat, 20 Dec 2014 22:41:24 +0100 19231f3 Sergio Jimenez Changed autostart_group to groups
Sat, 20 Dec 2014 14:28:37 +0100 c64d0f5 Sergio Jimenez Added autostart features to lxc type.
Tue, 16 Dec 2014 01:46:35 +0100 169ea13 Sergio Jimenez Allow to configure first interface.
Mon, 15 Dec 2014 16:52:58 +0100 0ff6383 Sergio Jimenez Removed networking from lxc type.
Sun, 14 Dec 2014 21:00:39 +0100 21abac9 Sergio Jimenez Added template_options to acceptance tests.
Sun, 14 Dec 2014 20:58:46 +0100 a9dc3d1 Sergio Jimenez Tried to overcome the ruby1.8 issue on Precise.
Sun, 14 Dec 2014 20:57:13 +0100 44facdc Sergio Jimenez Make sure rubygems is there when on Precise.
Sun, 14 Dec 2014 20:55:21 +0100 4959267 Sergio Jimenez Mods on beaker's nodes.
Sun, 14 Dec 2014 20:52:56 +0100 63d5c27 Sergio Jimenez Different list of packages for Trusty or Precise.
Sun, 14 Dec 2014 20:49:28 +0100 43ae761 Sergio Jimenez Added template_options parameter to lxc type.
Sun, 14 Dec 2014 20:46:48 +0100 8767e2c Sergio Jimenez Upgreded gems.
Fri, 12 Dec 2014 18:07:22 +0100 51124ae Sergio Jimenez Added basic acceptance tests, beaker-rspec
Fri, 12 Dec 2014 11:49:31 +0100 6aaac1a Sergio Jimenez Added support for Ubuntu Precise.
Mon, 13 Oct 2014 00:20:59 +0200 155e4da Sergio Jimenez Ready for release
Sun, 12 Oct 2014 21:15:16 +0200 2cb6ba7 Sergio Jimenez Flatten also for creating
Sun, 12 Oct 2014 21:08:58 +0200 facff80 Sergio Jimenez Match all values on the arrays
Sun, 12 Oct 2014 21:03:05 +0200 4c25cce Sergio Jimenez Flattening the array, puppet passes around array of arrays...?
Sun, 12 Oct 2014 19:45:14 +0200 77fcb6a Sergio Jimenez Start allowing arrays for ipv4
Thu, 9 Oct 2014 22:44:04 +0200 c0a3e83 Sergio Jimenez lxc_interface type, allow array of IPv4s
Thu, 9 Oct 2014 22:42:38 +0200 c801326 Sergio Jimenez lxc type, allow array of IPv4s
Thu, 9 Oct 2014 02:23:23 +0200 b103a01 Sergio Jimenez Added restart parameter to lxc_interface
Thu, 9 Oct 2014 02:22:50 +0200 5d2abe1 Sergio Jimenez Removed fixme paramter, was c&p
Thu, 9 Oct 2014 01:13:30 +0200 8dac2bd Sergio Jimenez Fixed clearing IPv4 gateway
Thu, 9 Oct 2014 00:37:16 +0200 edc2d10 Sergio Jimenez Added restart to lxc provider
Tue, 7 Oct 2014 00:03:20 +0200 01e9b35 Sergio Jimenez More info to README
Mon, 6 Oct 2014 23:56:36 +0200 aa7ebcb Sergio Jimenez Added restart parameter to lxc type
Mon, 6 Oct 2014 23:49:25 +0200 c19e35e Sergio Jimenez Added documentation to README
Sun, 5 Oct 2014 23:58:06 +0200 c455362 Sergio Jimenez Fixed test for lxc_interface type.
Sun, 5 Oct 2014 23:55:27 +0200 a22596a Sergio Jimenez Ban index 0 from lxc_interface provider.
Sun, 5 Oct 2014 23:51:01 +0200 045f10a Sergio Jimenez Fixed destroy for lxc_interface provider.
Sun, 5 Oct 2014 18:17:41 +0200 4c29724 Sergio Jimenez Small fixes on lxc provider for network config.
Sun, 5 Oct 2014 00:56:49 +0200 0a6f95f Sergio Jimenez Added ipv4_gateway to lxc provider
Sun, 5 Oct 2014 00:20:42 +0200 c770c71 Sergio Jimenez Added ipv4 to lxc provider
Sun, 28 Sep 2014 19:11:39 +0200 bbc4179 Sergio Jimenez Added ipv4 and ipv4_gateway to lxc type
Sun, 28 Sep 2014 13:09:25 +0200 78d6d14 Sergio Jimenez Added way to test ipv4 when liblxc >= 1.1.0 or < 1.1.0
Sun, 28 Sep 2014 12:44:46 +0200 f8753c0 Sergio Jimenez Fixed test for ipv4 getter
Fri, 26 Sep 2014 01:26:25 +0200 acad9d8 Sergio Jimenez ipv4 test almost done
Fri, 26 Sep 2014 01:15:34 +0200 a2978af Sergio Jimenez fixed broken tests
Fri, 26 Sep 2014 01:05:20 +0200 35f2cf7 Sergio Jimenez Modified #FIXME to allow arrays on ipv4
Fri, 26 Sep 2014 00:59:44 +0200 cd475ba Sergio Jimenez A bit dirty, but works, it should be an array
Fri, 26 Sep 2014 00:33:56 +0200 98a9943 Sergio Jimenez Typo, seems to work
Fri, 26 Sep 2014 00:28:07 +0200 46845b2 Sergio Jimenez Worse or better?
Thu, 25 Sep 2014 23:00:22 +0200 bfb9a36 Sergio Jimenez Hopefull the getter for ipv4 is working, it's a workaround until liblxc > 1.0.5 is released
Wed, 24 Sep 2014 01:15:37 +0200 ebb88bb Sergio Jimenez Seems the item has to cleared to avoid dups
Wed, 24 Sep 2014 01:11:49 +0200 fe6f2af Sergio Jimenez missing #save_config in setters
Wed, 24 Sep 2014 00:54:54 +0200 3a121bb Sergio Jimenez ipv4 getter should be working now, skipping test until I find a good way for it.
Mon, 22 Sep 2014 00:12:41 +0200 9d2b821 Sergio Jimenez Removed tags, have not found any useful use for it
Sun, 21 Sep 2014 00:56:27 +0200 0e84ded Sergio Jimenez Added note to fix/remove flags, down does not work
Sun, 21 Sep 2014 00:55:11 +0200 67006b9 Sergio Jimenez Added note to fix ipv4 as bindings do not return mask.
Sun, 21 Sep 2014 00:53:21 +0200 9a7c8dd Sergio Jimenez seems order matters here
Sun, 21 Sep 2014 00:52:14 +0200 be7d2e5 Sergio Jimenez @resource is not yet there, have to use self
Sat, 20 Sep 2014 13:45:13 +0200 ac35da3 Sergio Jimenez lxc_interface should be ready for a real test
Sat, 20 Sep 2014 00:26:18 +0200 d017ed6 Sergio Jimenez #create and its tests for lxc_interface
Mon, 15 Sep 2014 00:35:42 +0200 d9f73e7 Sergio Jimenez Initial work for lxc_interface provider
Sun, 14 Sep 2014 23:34:31 +0200 2feba87 Sergio Jimenez Container name is now required
Sun, 14 Sep 2014 23:23:37 +0200 b9fbd19 Sergio Jimenez Network type default to veth
Sun, 14 Sep 2014 23:20:50 +0200 75066a6 Sergio Jimenez Flags to 'up' and make container to be required.
Sun, 14 Sep 2014 22:29:05 +0200 d767f95 Sergio Jimenez Fixed test for parameters and add index.
Sun, 14 Sep 2014 19:32:20 +0200 d1e418c Sergio Jimenez Initial rspec tests for Lxc_interface type
Sun, 14 Sep 2014 19:32:01 +0200 1aa35ae Sergio Jimenez Initial work for Lxc_interface type
Sat, 13 Sep 2014 13:42:39 +0200 050e0af Sergio Jimenez Updated version on metadata.json and bumped to 0.2.1
Sat, 13 Sep 2014 13:30:29 +0200 0be9930 Sergio Jimenez Getting ready for the forge
Sat, 13 Sep 2014 12:31:11 +0200 cc45bb6 Sergio Jimenez gemfile.lock
Sat, 13 Sep 2014 12:18:19 +0200 bb15cbc Sergio Jimenez Avoid duplicating travis runs
Sat, 13 Sep 2014 12:10:31 +0200 e547ddb Sergio Jimenez Adding build status
Sat, 13 Sep 2014 12:05:17 +0200 a2374b8 Sergio Jimenez Trying to make Travis happy...
Sat, 13 Sep 2014 12:02:17 +0200 d9b91da Sergio Jimenez RVM versions
Sat, 13 Sep 2014 11:54:52 +0200 3044e8f Sergio Jimenez non-default Gemfile
Sat, 13 Sep 2014 11:47:57 +0200 d578ebd Sergio Jimenez non-interactive
Sat, 13 Sep 2014 11:44:57 +0200 334f654 Sergio Jimenez Add lxc PPA, does travis run precise?
Sat, 13 Sep 2014 11:40:40 +0200 b2cceae Sergio Jimenez First attempt...travis.yml
Sat, 13 Sep 2014 11:40:13 +0200 9d4589d Sergio Jimenez Missing ruby-lxc
Sat, 13 Sep 2014 11:30:20 +0200 b308ee8 Sergio Jimenez Getting ready for travis-ci
Fri, 12 Sep 2014 01:11:17 +0200 d8c1342 Sergio Jimenez Author name, is name...
Tue, 9 Sep 2014 01:44:39 +0200 62d214d Sergio Jimenez More and better looking tests
Tue, 9 Sep 2014 01:44:18 +0200 f8593d6 Sergio Jimenez Better storage_options validation
Tue, 9 Sep 2014 01:39:40 +0200 e7bf626 Sergio Jimenez Use resource instance variable
Sun, 7 Sep 2014 20:09:44 +0200 4375922 Sergio Jimenez Initial tests for provider
Sun, 7 Sep 2014 20:07:59 +0200 c116936 Sergio Jimenez Explicit rspec gems
Fri, 5 Sep 2014 02:43:44 +0200 ace6fe5 Sergio Jimenez #symbolize_hash private
Fri, 5 Sep 2014 02:42:14 +0200 64d860b Sergio Jimenez added ruby-lxc
Thu, 4 Sep 2014 00:21:51 +0200 35877f3 Sergio Jimenez type tested
Thu, 4 Sep 2014 00:21:26 +0200 2b76d0b Sergio Jimenez Added comment about not so good validation for storage_options parameter
Thu, 4 Sep 2014 00:20:52 +0200 dc487d8 Sergio Jimenez back to default output for rspec
Wed, 3 Sep 2014 01:41:23 +0200 13b3c03 Sergio Jimenez Partial tests for lxc type
Tue, 2 Sep 2014 00:27:47 +0200 8b10295 Sergio Jimenez Fixed metadata.json as it made catalog compilation to fail (?)
Tue, 2 Sep 2014 00:27:13 +0200 471f299 Sergio Jimenez rspec options
Mon, 1 Sep 2014 01:21:25 +0200 307ca9b Sergio Jimenez More TODO
Mon, 1 Sep 2014 01:20:10 +0200 5b2c1f0 Sergio Jimenez Added TODO section
Mon, 1 Sep 2014 01:15:47 +0200 b5ef1fd Sergio Jimenez Added Apache-2.0 license
Mon, 1 Sep 2014 01:15:33 +0200 089b5b4 Sergio Jimenez Fixed metadata.json
Mon, 1 Sep 2014 01:11:22 +0200 76ffa74 Sergio Jimenez README index
Mon, 1 Sep 2014 01:10:12 +0200 099f9be Sergio Jimenez More informative README
Mon, 1 Sep 2014 00:30:11 +0200 3c4aa58 Sergio Jimenez Initial tests
Mon, 1 Sep 2014 00:29:50 +0200 344bccc Sergio Jimenez More stuff working and added feature lxc
Mon, 1 Sep 2014 00:29:17 +0200 7828735 Sergio Jimenez Puppet spec helper
Mon, 1 Sep 2014 00:28:52 +0200 97988fa Sergio Jimenez Params, gem build deps, ...
Mon, 1 Sep 2014 00:28:03 +0200 be2bfc9 Sergio Jimenez Custom Rakefile
Mon, 1 Sep 2014 00:27:20 +0200 4979579 Sergio Jimenez Bundler
Mon, 1 Sep 2014 00:26:56 +0200 1b535ea Sergio Jimenez Added basic fixtures file
Tue, 19 Aug 2014 01:09:17 +0200 d093516 Sergio Jimenez Confined to ubuntu and state default to running
Tue, 19 Aug 2014 00:35:36 +0200 e584614 Sergio Jimenez Storage backend support
Sun, 17 Aug 2014 18:22:57 +0000 c80d417 Sergio Jimenez Initial import, rudimentary initial provider
