# No separate team for development artifacts

If admin/devops should work with main repo, he/she should be fully part of dev team and follow all software
development rules and processes (code reviews) - no exceptions.

Examples:

* Admin/devops doesn't write alone **ANY CODE** in any lang(for encryption, decryption, software setup, init scripts,
  Dockerfile, helper scripts, ...), separately from dev team. They follow same rules as dev team.

Once admin wrote init script. Same time developer wrote init script.

Once admin wrote base64 encryption/decryption script. That didn't work correctly.

Once admin wrote code that was handy (reusable) for other things, but was not written in re-usability in mind and by
"good code" rules.
