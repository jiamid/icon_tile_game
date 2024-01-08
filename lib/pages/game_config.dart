import 'package:flutter/material.dart';

Map boxColorMap = {
  0: Colors.black12,
  1: Colors.redAccent,
  2: Colors.greenAccent,
  3: Colors.amber,
  4: Colors.blue,
  5: Colors.purple,
  6: Colors.grey,
  7: Colors.white,
  8: Colors.lightBlue,
  9: Colors.green,
  10: Colors.red,
  11: Colors.yellowAccent,
  12: Colors.pinkAccent,
  13: Colors.brown,
  14: Colors.teal,
};
final List<int> allType = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

final Map<int, Map<int, List<int>>> levelOffsetMap = {
  1: {
    0: [5, 5, 3, 4, 5, 6, 7, 7, 7, 7],
    1: [1, 2, 3, 4, 5, 6, 7, 7, 7, 7]
  },
  3: {
    0: [
      5,
      2,
      2,
      4,
      6,
    ],
    1: [
      5,
      2,
      2,
      4,
      6,
    ]
  },
  4: {
    0: [2, 3, 28, 2],
    1: [1, 2, 2, 28]
  },
  5: {
    0: [0, -28, 20, 5],
    1: [28, 0, 0, 0]
  },
  6: {
    0: [2, 2, 3, 3, 28, 3, 4, 5, 6],
    1: [1, 1, 2, 2, 22, 2, 3, 4, 5]
  },
};

Map<int, List<int>> levelTypeMap = {
  1: [6, 6, 6],
  2: [6, 6, 6, 3, 3, 3, 3],
  3: [6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3],
  4: [6, 6, 12, 3, 6, 9, 9, 6, 6, 9, 6, 6, 18, 9],
  5: [6, 6, 12, 3, 6, 9, 9, 6, 6, 9, 6, 6, 18, 9],
  6: [18, 18, 15, 15, 15, 12, 12, 12, 12, 9, 9, 9, 9],
};

Map<int, List<List<List<int>>>> levelMap = {
  1: [
    [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ],
    [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]
  ],
  2: [
    [
      [-1, 0, 0, -1],
      [-1, 0, 0, -1],
      [-1, -1, -1, -1],
      [-1, 0, 0, -1]
    ],
    [
      [0, 0, 0, 0],
      [-1, 0, 0, -1],
      [-1, 0, 0, -1],
      [-1, 0, 0, -1]
    ],
    [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [-1, 0, 0, -1],
      [0, 0, 0, 0]
    ]
  ],
  3: [
    [
      [0, 0, 0, 0, 0, 0, 0],
      [0, -1, -1, -1, -1, -1, 0],
      [0, -1, -1, -1, -1, -1, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, -1, -1, -1, -1, -1, 0],
      [0, -1, -1, -1, -1, -1, 0],
      [0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, 0, 0, -1, -1],
      [-1, -1, 0, -1, 0, -1, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, 0, 0, -1, -1],
      [-1, -1, 0, -1, 0, -1, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, 0, 0, -1, -1],
      [-1, -1, 0, -1, 0, -1, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, 0, 0, -1, -1],
      [-1, -1, 0, -1, 0, -1, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
  ],
  4: [
    [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
    ]
  ],
  5: [
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0, 0],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, 0, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
    ],
  ],
  6: [
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, 0, 0, -1, 0, 0, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [0, 0, 0, 0, 0, 0, -1],
      [0, 0, 0, 0, 0, 0, -1],
      [0, 0, 0, 0, 0, 0, -1],
      [0, 0, 0, 0, 0, 0, -1],
      [0, 0, 0, 0, 0, 0, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
    ],
    [
      [0, 0, 0, -1, 0, 0, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, 0, 0, 0, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, 0, 0, -1, 0, 0, 0],
    ],
    [
      [0, 0, 0, -1, 0, 0, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, -1, 0, 0, 0, -1, 0],
      [0, -1, 0, 0, 0, -1, 0],
      [0, -1, 0, 0, 0, -1, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, 0, 0, -1, 0, 0, 0],
    ],
    [
      [0, 0, 0, -1, 0, 0, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, -1, 0, 0, 0, -1, 0],
      [0, -1, 0, 0, 0, -1, 0],
      [0, -1, 0, 0, 0, -1, 0],
      [-1, -1, -1, -1, -1, -1, -1],
      [0, 0, 0, -1, 0, 0, 0],
    ],
  ]
};
