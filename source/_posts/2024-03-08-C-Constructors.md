---
title: C-Constructors
date: 2024-03-08 23:37:36
tags:
  - [學習]
categories:
  - [C#]
---

C#建構函式


<!--more-->
---


# 建構函式（Constructor）的深入解析與實戰

## 建構函式的基本概念
- **定義**：建構函式是一種特殊的方法，當類別的實例被創建時自動呼叫。
- **作用**：初始化類別的某些字段，將物件置於初始狀態。

## 建構函式的聲明方式
- **命名規則**：建構函式的名稱必須與類別名稱完全相同。
- **返回類型**：建構函式不應有返回類型，連`void`也不應有。

## 建構函式的類型
- **無參建構函式（預設建構函式）**：不帶任何參數，若未明確定義，C#編譯器會自動生成。
- **帶參建構函式**：可接受一個或多個參數，用於更靈活地初始化對象。

## 建構函式的重載（Overloading）
- **意義**：同一類別中可以有多個名稱相同但參數列表不同的建構函式。
- **目的**：提供不同的初始化選項。

## 程式實戰演練
### 定義一個Customer類別
```csharp
public class Customer {
    public int ID;
    public string Name;

    // 預設建構函式
    public Customer() {
        ID = 0;
        Name = null;
    }

    // 帶參建構函式
    public Customer(int id, string name) {
        ID = id;
        Name = name;
    }
}
```

### 實例化與使用
```csharp
Customer customerA = new Customer();
Customer customerB = new Customer(1, "John");
```

## 進階主題：建構函式的鏈接
- 使用`this`關鍵字實現建構函式間的調用。

### 例子
```csharp
public class Customer {
    public int ID;
    public string Name;
    public List<Order> Orders;

    public Customer() : this(0, null) {
        Orders = new List<Order>();
    }

    public Customer(int id, string name) {
        ID = id;
        Name = name;
        // 這樣確保了無論使用哪個建構函式，Orders都會被初始化
        Orders = new List<Order>();
    }
}
```

