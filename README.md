# JSONExtensions

Some minor supporting utilities for Swift JSON parsing.

## Error Translation

Adds `isJSONError` and `jsonErrorDescription` to Error, which provide a way to test for JSON parsing errors, and a better description of them.

## JSONSerialization

Adds a convenience method to decode direct from a `String`.

Adds convenience decoding methods which don't throw, but instead take an error handler. The error handler is passed the thrown error, but also a pre-formatted description of the error, produced by `jsonErrorDescription`.
