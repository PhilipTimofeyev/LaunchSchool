## Methods



| <u>**Method**</u>  | <u>**Action**</u> | <u>Considers the return value of the block?</u> | <u>Returns a new collection from the method?</u> | <u>Length of returned collection</u> | <u>**Notes**</u>                                             |
| :----------------: | ----------------- | ----------------------------------------------- | ------------------------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
|        each        | iteration         | no                                              | No, returns the original                         | length of original                   |                                                              |
|       select       | selection         | yes, its truthiness                             | yes                                              | length of original or less           | selects elements that are truthy                             |
|        map         | transformation    | yes                                             | yes                                              | length of original                   | maps the return of the block. If called on hash, returns array.i |
|        any         | iteration         | yes                                             | no                                               | returns boolean                      | returns `true` if any blocks evalutate to `true`. Short circuit |
|        all         | iteration         | yes                                             | no                                               | returns boolean                      | returns `true` if all blocks evaluate to `true`              |
|  each_with_index   | iteration         | no                                              | No, returns the original                         | length of original                   | takes a second argument which represents the index           |
| each.with_index()  | iteration         | no                                              | No, returns the original                         | length of the original               | takes optional parameter to offset the index                 |
| each_with_object() | iteration         | no                                              | returns the object                               | varies                               | takes a second argument which represents the object          |
|       first        | -                 |                                                 |                                                  |                                      | If called on a hash, returns an array.                       |
|     include?()     |                   |                                                 |                                                  |                                      | Returns `true` if the argument exists in the collection.     |
|     partition      |                   |                                                 |                                                  |                                      | partitions based on the truthiness of block. Always returns array |
|        sort        |                   | yes, block requires two arguments               | yes, sorted according to value                   | length of original                   | Comparison is at the heart of how sorting works. Only cares about hte return value of  <=> |
|      sort_by       |                   | yes                                             | yes, always an array                             |                                      | Cannot call sort_by! on hash                                 |

