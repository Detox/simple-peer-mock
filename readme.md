# simple-peer-mock
This is a mock for `simple-peer` library, it provides API that Detox project uses and offers it without actual WebRTC under the hood, so that tests can create more connections with lower CPU/RAM usage.

# How to install
```
npm install --save-dev github:Detox/simple-peer-mock
```
# How to use
```javascript
const simplePeerMock = require('@detox/simple-peer-mock').simplePeerMock; // This is a constructor
require('@detox/simple-peer-mock').register() // This will replace `@detox/simple-peer` package globally
```

## Contribution
Feel free to create issues and send pull requests (for big changes create an issue first and link it from the PR), they are highly appreciated!

When reading LiveScript code make sure to configure 1 tab to be 4 spaces (GitHub uses 8 by default), otherwise code might be hard to read.

## License
Free Public License 1.0.0 / Zero Clause BSD License

https://opensource.org/licenses/FPL-1.0.0

https://tldrlegal.com/license/bsd-0-clause-license
