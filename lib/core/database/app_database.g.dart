// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTableTable extends WordsTable
    with TableInfo<$WordsTableTable, WordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _definitionMeta =
      const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
      'definition', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleMeta =
      const VerificationMeta('example');
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
      'example', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usageMeta = const VerificationMeta('usage');
  @override
  late final GeneratedColumn<String> usage = GeneratedColumn<String>(
      'usage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _complexityMeta =
      const VerificationMeta('complexity');
  @override
  late final GeneratedColumn<String> complexity = GeneratedColumn<String>(
      'complexity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, word, definition, example, usage, complexity, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words_table';
  @override
  VerificationContext validateIntegrity(Insertable<WordsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('example')) {
      context.handle(_exampleMeta,
          example.isAcceptableOrUnknown(data['example']!, _exampleMeta));
    } else if (isInserting) {
      context.missing(_exampleMeta);
    }
    if (data.containsKey('usage')) {
      context.handle(
          _usageMeta, usage.isAcceptableOrUnknown(data['usage']!, _usageMeta));
    } else if (isInserting) {
      context.missing(_usageMeta);
    }
    if (data.containsKey('complexity')) {
      context.handle(
          _complexityMeta,
          complexity.isAcceptableOrUnknown(
              data['complexity']!, _complexityMeta));
    } else if (isInserting) {
      context.missing(_complexityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      definition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}definition'])!,
      example: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example'])!,
      usage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}usage'])!,
      complexity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}complexity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $WordsTableTable createAlias(String alias) {
    return $WordsTableTable(attachedDatabase, alias);
  }
}

class WordsTableData extends DataClass implements Insertable<WordsTableData> {
  final int id;
  final String word;
  final String definition;
  final String example;
  final String usage;
  final String complexity;
  final DateTime? createdAt;
  const WordsTableData(
      {required this.id,
      required this.word,
      required this.definition,
      required this.example,
      required this.usage,
      required this.complexity,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['definition'] = Variable<String>(definition);
    map['example'] = Variable<String>(example);
    map['usage'] = Variable<String>(usage);
    map['complexity'] = Variable<String>(complexity);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  WordsTableCompanion toCompanion(bool nullToAbsent) {
    return WordsTableCompanion(
      id: Value(id),
      word: Value(word),
      definition: Value(definition),
      example: Value(example),
      usage: Value(usage),
      complexity: Value(complexity),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory WordsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordsTableData(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      definition: serializer.fromJson<String>(json['definition']),
      example: serializer.fromJson<String>(json['example']),
      usage: serializer.fromJson<String>(json['usage']),
      complexity: serializer.fromJson<String>(json['complexity']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'definition': serializer.toJson<String>(definition),
      'example': serializer.toJson<String>(example),
      'usage': serializer.toJson<String>(usage),
      'complexity': serializer.toJson<String>(complexity),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  WordsTableData copyWith(
          {int? id,
          String? word,
          String? definition,
          String? example,
          String? usage,
          String? complexity,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      WordsTableData(
        id: id ?? this.id,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        example: example ?? this.example,
        usage: usage ?? this.usage,
        complexity: complexity ?? this.complexity,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  WordsTableData copyWithCompanion(WordsTableCompanion data) {
    return WordsTableData(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      definition:
          data.definition.present ? data.definition.value : this.definition,
      example: data.example.present ? data.example.value : this.example,
      usage: data.usage.present ? data.usage.value : this.usage,
      complexity:
          data.complexity.present ? data.complexity.value : this.complexity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordsTableData(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition, ')
          ..write('example: $example, ')
          ..write('usage: $usage, ')
          ..write('complexity: $complexity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, word, definition, example, usage, complexity, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordsTableData &&
          other.id == this.id &&
          other.word == this.word &&
          other.definition == this.definition &&
          other.example == this.example &&
          other.usage == this.usage &&
          other.complexity == this.complexity &&
          other.createdAt == this.createdAt);
}

class WordsTableCompanion extends UpdateCompanion<WordsTableData> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> definition;
  final Value<String> example;
  final Value<String> usage;
  final Value<String> complexity;
  final Value<DateTime?> createdAt;
  const WordsTableCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
    this.example = const Value.absent(),
    this.usage = const Value.absent(),
    this.complexity = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordsTableCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String definition,
    required String example,
    required String usage,
    required String complexity,
    this.createdAt = const Value.absent(),
  })  : word = Value(word),
        definition = Value(definition),
        example = Value(example),
        usage = Value(usage),
        complexity = Value(complexity);
  static Insertable<WordsTableData> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? definition,
    Expression<String>? example,
    Expression<String>? usage,
    Expression<String>? complexity,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (definition != null) 'definition': definition,
      if (example != null) 'example': example,
      if (usage != null) 'usage': usage,
      if (complexity != null) 'complexity': complexity,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? word,
      Value<String>? definition,
      Value<String>? example,
      Value<String>? usage,
      Value<String>? complexity,
      Value<DateTime?>? createdAt}) {
    return WordsTableCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      usage: usage ?? this.usage,
      complexity: complexity ?? this.complexity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (usage.present) {
      map['usage'] = Variable<String>(usage.value);
    }
    if (complexity.present) {
      map['complexity'] = Variable<String>(complexity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsTableCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition, ')
          ..write('example: $example, ')
          ..write('usage: $usage, ')
          ..write('complexity: $complexity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SentencesTableTable extends SentencesTable
    with TableInfo<$SentencesTableTable, SentencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sentenceMeta =
      const VerificationMeta('sentence');
  @override
  late final GeneratedColumn<String> sentence = GeneratedColumn<String>(
      'sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
      'tip', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _complexityMeta =
      const VerificationMeta('complexity');
  @override
  late final GeneratedColumn<String> complexity = GeneratedColumn<String>(
      'complexity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sentence, explanation, tip, complexity, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentences_table';
  @override
  VerificationContext validateIntegrity(Insertable<SentencesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sentence')) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableOrUnknown(data['sentence']!, _sentenceMeta));
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('tip')) {
      context.handle(
          _tipMeta, tip.isAcceptableOrUnknown(data['tip']!, _tipMeta));
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('complexity')) {
      context.handle(
          _complexityMeta,
          complexity.isAcceptableOrUnknown(
              data['complexity']!, _complexityMeta));
    } else if (isInserting) {
      context.missing(_complexityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SentencesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentencesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sentence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentence'])!,
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation'])!,
      tip: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tip'])!,
      complexity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}complexity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SentencesTableTable createAlias(String alias) {
    return $SentencesTableTable(attachedDatabase, alias);
  }
}

class SentencesTableData extends DataClass
    implements Insertable<SentencesTableData> {
  final int id;
  final String sentence;
  final String explanation;
  final String tip;
  final String complexity;
  final DateTime createdAt;
  const SentencesTableData(
      {required this.id,
      required this.sentence,
      required this.explanation,
      required this.tip,
      required this.complexity,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sentence'] = Variable<String>(sentence);
    map['explanation'] = Variable<String>(explanation);
    map['tip'] = Variable<String>(tip);
    map['complexity'] = Variable<String>(complexity);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SentencesTableCompanion toCompanion(bool nullToAbsent) {
    return SentencesTableCompanion(
      id: Value(id),
      sentence: Value(sentence),
      explanation: Value(explanation),
      tip: Value(tip),
      complexity: Value(complexity),
      createdAt: Value(createdAt),
    );
  }

  factory SentencesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentencesTableData(
      id: serializer.fromJson<int>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
      explanation: serializer.fromJson<String>(json['explanation']),
      tip: serializer.fromJson<String>(json['tip']),
      complexity: serializer.fromJson<String>(json['complexity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sentence': serializer.toJson<String>(sentence),
      'explanation': serializer.toJson<String>(explanation),
      'tip': serializer.toJson<String>(tip),
      'complexity': serializer.toJson<String>(complexity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SentencesTableData copyWith(
          {int? id,
          String? sentence,
          String? explanation,
          String? tip,
          String? complexity,
          DateTime? createdAt}) =>
      SentencesTableData(
        id: id ?? this.id,
        sentence: sentence ?? this.sentence,
        explanation: explanation ?? this.explanation,
        tip: tip ?? this.tip,
        complexity: complexity ?? this.complexity,
        createdAt: createdAt ?? this.createdAt,
      );
  SentencesTableData copyWithCompanion(SentencesTableCompanion data) {
    return SentencesTableData(
      id: data.id.present ? data.id.value : this.id,
      sentence: data.sentence.present ? data.sentence.value : this.sentence,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      tip: data.tip.present ? data.tip.value : this.tip,
      complexity:
          data.complexity.present ? data.complexity.value : this.complexity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SentencesTableData(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('explanation: $explanation, ')
          ..write('tip: $tip, ')
          ..write('complexity: $complexity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sentence, explanation, tip, complexity, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentencesTableData &&
          other.id == this.id &&
          other.sentence == this.sentence &&
          other.explanation == this.explanation &&
          other.tip == this.tip &&
          other.complexity == this.complexity &&
          other.createdAt == this.createdAt);
}

class SentencesTableCompanion extends UpdateCompanion<SentencesTableData> {
  final Value<int> id;
  final Value<String> sentence;
  final Value<String> explanation;
  final Value<String> tip;
  final Value<String> complexity;
  final Value<DateTime> createdAt;
  const SentencesTableCompanion({
    this.id = const Value.absent(),
    this.sentence = const Value.absent(),
    this.explanation = const Value.absent(),
    this.tip = const Value.absent(),
    this.complexity = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SentencesTableCompanion.insert({
    this.id = const Value.absent(),
    required String sentence,
    required String explanation,
    required String tip,
    required String complexity,
    this.createdAt = const Value.absent(),
  })  : sentence = Value(sentence),
        explanation = Value(explanation),
        tip = Value(tip),
        complexity = Value(complexity);
  static Insertable<SentencesTableData> custom({
    Expression<int>? id,
    Expression<String>? sentence,
    Expression<String>? explanation,
    Expression<String>? tip,
    Expression<String>? complexity,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentence != null) 'sentence': sentence,
      if (explanation != null) 'explanation': explanation,
      if (tip != null) 'tip': tip,
      if (complexity != null) 'complexity': complexity,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SentencesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? sentence,
      Value<String>? explanation,
      Value<String>? tip,
      Value<String>? complexity,
      Value<DateTime>? createdAt}) {
    return SentencesTableCompanion(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      explanation: explanation ?? this.explanation,
      tip: tip ?? this.tip,
      complexity: complexity ?? this.complexity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sentence.present) {
      map['sentence'] = Variable<String>(sentence.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (complexity.present) {
      map['complexity'] = Variable<String>(complexity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentencesTableCompanion(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('explanation: $explanation, ')
          ..write('tip: $tip, ')
          ..write('complexity: $complexity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuizTableTable extends QuizTable
    with TableInfo<$QuizTableTable, QuizTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sentenceMeta =
      const VerificationMeta('sentence');
  @override
  late final GeneratedColumn<String> sentence = GeneratedColumn<String>(
      'sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsMeta =
      const VerificationMeta('options');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      options = GeneratedColumn<String>('options', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $QuizTableTable.$converteroptions);
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _complexityMeta =
      const VerificationMeta('complexity');
  @override
  late final GeneratedColumn<String> complexity = GeneratedColumn<String>(
      'complexity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sentence, options, correctAnswer, complexity, type, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_table';
  @override
  VerificationContext validateIntegrity(Insertable<QuizTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sentence')) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableOrUnknown(data['sentence']!, _sentenceMeta));
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    context.handle(_optionsMeta, const VerificationResult.success());
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    } else if (isInserting) {
      context.missing(_correctAnswerMeta);
    }
    if (data.containsKey('complexity')) {
      context.handle(
          _complexityMeta,
          complexity.isAcceptableOrUnknown(
              data['complexity']!, _complexityMeta));
    } else if (isInserting) {
      context.missing(_complexityMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sentence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentence'])!,
      options: $QuizTableTable.$converteroptions.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options'])!),
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer'])!,
      complexity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}complexity'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $QuizTableTable createAlias(String alias) {
    return $QuizTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converteroptions =
      const MapConverter();
}

class QuizTableData extends DataClass implements Insertable<QuizTableData> {
  final int id;
  final String sentence;
  final Map<String, String> options;
  final String correctAnswer;
  final String complexity;
  final String type;
  final DateTime createdAt;
  const QuizTableData(
      {required this.id,
      required this.sentence,
      required this.options,
      required this.correctAnswer,
      required this.complexity,
      required this.type,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sentence'] = Variable<String>(sentence);
    {
      map['options'] =
          Variable<String>($QuizTableTable.$converteroptions.toSql(options));
    }
    map['correct_answer'] = Variable<String>(correctAnswer);
    map['complexity'] = Variable<String>(complexity);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuizTableCompanion toCompanion(bool nullToAbsent) {
    return QuizTableCompanion(
      id: Value(id),
      sentence: Value(sentence),
      options: Value(options),
      correctAnswer: Value(correctAnswer),
      complexity: Value(complexity),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory QuizTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizTableData(
      id: serializer.fromJson<int>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
      options: serializer.fromJson<Map<String, String>>(json['options']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      complexity: serializer.fromJson<String>(json['complexity']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sentence': serializer.toJson<String>(sentence),
      'options': serializer.toJson<Map<String, String>>(options),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'complexity': serializer.toJson<String>(complexity),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QuizTableData copyWith(
          {int? id,
          String? sentence,
          Map<String, String>? options,
          String? correctAnswer,
          String? complexity,
          String? type,
          DateTime? createdAt}) =>
      QuizTableData(
        id: id ?? this.id,
        sentence: sentence ?? this.sentence,
        options: options ?? this.options,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        complexity: complexity ?? this.complexity,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );
  QuizTableData copyWithCompanion(QuizTableCompanion data) {
    return QuizTableData(
      id: data.id.present ? data.id.value : this.id,
      sentence: data.sentence.present ? data.sentence.value : this.sentence,
      options: data.options.present ? data.options.value : this.options,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      complexity:
          data.complexity.present ? data.complexity.value : this.complexity,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizTableData(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('options: $options, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('complexity: $complexity, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, sentence, options, correctAnswer, complexity, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizTableData &&
          other.id == this.id &&
          other.sentence == this.sentence &&
          other.options == this.options &&
          other.correctAnswer == this.correctAnswer &&
          other.complexity == this.complexity &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class QuizTableCompanion extends UpdateCompanion<QuizTableData> {
  final Value<int> id;
  final Value<String> sentence;
  final Value<Map<String, String>> options;
  final Value<String> correctAnswer;
  final Value<String> complexity;
  final Value<String> type;
  final Value<DateTime> createdAt;
  const QuizTableCompanion({
    this.id = const Value.absent(),
    this.sentence = const Value.absent(),
    this.options = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.complexity = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuizTableCompanion.insert({
    this.id = const Value.absent(),
    required String sentence,
    required Map<String, String> options,
    required String correctAnswer,
    required String complexity,
    required String type,
    this.createdAt = const Value.absent(),
  })  : sentence = Value(sentence),
        options = Value(options),
        correctAnswer = Value(correctAnswer),
        complexity = Value(complexity),
        type = Value(type);
  static Insertable<QuizTableData> custom({
    Expression<int>? id,
    Expression<String>? sentence,
    Expression<String>? options,
    Expression<String>? correctAnswer,
    Expression<String>? complexity,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentence != null) 'sentence': sentence,
      if (options != null) 'options': options,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (complexity != null) 'complexity': complexity,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuizTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? sentence,
      Value<Map<String, String>>? options,
      Value<String>? correctAnswer,
      Value<String>? complexity,
      Value<String>? type,
      Value<DateTime>? createdAt}) {
    return QuizTableCompanion(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      complexity: complexity ?? this.complexity,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sentence.present) {
      map['sentence'] = Variable<String>(sentence.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(
          $QuizTableTable.$converteroptions.toSql(options.value));
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (complexity.present) {
      map['complexity'] = Variable<String>(complexity.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizTableCompanion(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('options: $options, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('complexity: $complexity, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTableTable wordsTable = $WordsTableTable(this);
  late final $SentencesTableTable sentencesTable = $SentencesTableTable(this);
  late final $QuizTableTable quizTable = $QuizTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [wordsTable, sentencesTable, quizTable];
}

typedef $$WordsTableTableCreateCompanionBuilder = WordsTableCompanion Function({
  Value<int> id,
  required String word,
  required String definition,
  required String example,
  required String usage,
  required String complexity,
  Value<DateTime?> createdAt,
});
typedef $$WordsTableTableUpdateCompanionBuilder = WordsTableCompanion Function({
  Value<int> id,
  Value<String> word,
  Value<String> definition,
  Value<String> example,
  Value<String> usage,
  Value<String> complexity,
  Value<DateTime?> createdAt,
});

class $$WordsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WordsTableTable> {
  $$WordsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get word => $state.composableBuilder(
      column: $state.table.word,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get definition => $state.composableBuilder(
      column: $state.table.definition,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get example => $state.composableBuilder(
      column: $state.table.example,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get usage => $state.composableBuilder(
      column: $state.table.usage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WordsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WordsTableTable> {
  $$WordsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get word => $state.composableBuilder(
      column: $state.table.word,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get definition => $state.composableBuilder(
      column: $state.table.definition,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get example => $state.composableBuilder(
      column: $state.table.example,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get usage => $state.composableBuilder(
      column: $state.table.usage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$WordsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordsTableTable,
    WordsTableData,
    $$WordsTableTableFilterComposer,
    $$WordsTableTableOrderingComposer,
    $$WordsTableTableCreateCompanionBuilder,
    $$WordsTableTableUpdateCompanionBuilder,
    (
      WordsTableData,
      BaseReferences<_$AppDatabase, $WordsTableTable, WordsTableData>
    ),
    WordsTableData,
    PrefetchHooks Function()> {
  $$WordsTableTableTableManager(_$AppDatabase db, $WordsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WordsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WordsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> definition = const Value.absent(),
            Value<String> example = const Value.absent(),
            Value<String> usage = const Value.absent(),
            Value<String> complexity = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              WordsTableCompanion(
            id: id,
            word: word,
            definition: definition,
            example: example,
            usage: usage,
            complexity: complexity,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String word,
            required String definition,
            required String example,
            required String usage,
            required String complexity,
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              WordsTableCompanion.insert(
            id: id,
            word: word,
            definition: definition,
            example: example,
            usage: usage,
            complexity: complexity,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordsTableTable,
    WordsTableData,
    $$WordsTableTableFilterComposer,
    $$WordsTableTableOrderingComposer,
    $$WordsTableTableCreateCompanionBuilder,
    $$WordsTableTableUpdateCompanionBuilder,
    (
      WordsTableData,
      BaseReferences<_$AppDatabase, $WordsTableTable, WordsTableData>
    ),
    WordsTableData,
    PrefetchHooks Function()>;
typedef $$SentencesTableTableCreateCompanionBuilder = SentencesTableCompanion
    Function({
  Value<int> id,
  required String sentence,
  required String explanation,
  required String tip,
  required String complexity,
  Value<DateTime> createdAt,
});
typedef $$SentencesTableTableUpdateCompanionBuilder = SentencesTableCompanion
    Function({
  Value<int> id,
  Value<String> sentence,
  Value<String> explanation,
  Value<String> tip,
  Value<String> complexity,
  Value<DateTime> createdAt,
});

class $$SentencesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SentencesTableTable> {
  $$SentencesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sentence => $state.composableBuilder(
      column: $state.table.sentence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get explanation => $state.composableBuilder(
      column: $state.table.explanation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tip => $state.composableBuilder(
      column: $state.table.tip,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SentencesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SentencesTableTable> {
  $$SentencesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sentence => $state.composableBuilder(
      column: $state.table.sentence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get explanation => $state.composableBuilder(
      column: $state.table.explanation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tip => $state.composableBuilder(
      column: $state.table.tip,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$SentencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SentencesTableTable,
    SentencesTableData,
    $$SentencesTableTableFilterComposer,
    $$SentencesTableTableOrderingComposer,
    $$SentencesTableTableCreateCompanionBuilder,
    $$SentencesTableTableUpdateCompanionBuilder,
    (
      SentencesTableData,
      BaseReferences<_$AppDatabase, $SentencesTableTable, SentencesTableData>
    ),
    SentencesTableData,
    PrefetchHooks Function()> {
  $$SentencesTableTableTableManager(
      _$AppDatabase db, $SentencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SentencesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SentencesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sentence = const Value.absent(),
            Value<String> explanation = const Value.absent(),
            Value<String> tip = const Value.absent(),
            Value<String> complexity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SentencesTableCompanion(
            id: id,
            sentence: sentence,
            explanation: explanation,
            tip: tip,
            complexity: complexity,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sentence,
            required String explanation,
            required String tip,
            required String complexity,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SentencesTableCompanion.insert(
            id: id,
            sentence: sentence,
            explanation: explanation,
            tip: tip,
            complexity: complexity,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SentencesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SentencesTableTable,
    SentencesTableData,
    $$SentencesTableTableFilterComposer,
    $$SentencesTableTableOrderingComposer,
    $$SentencesTableTableCreateCompanionBuilder,
    $$SentencesTableTableUpdateCompanionBuilder,
    (
      SentencesTableData,
      BaseReferences<_$AppDatabase, $SentencesTableTable, SentencesTableData>
    ),
    SentencesTableData,
    PrefetchHooks Function()>;
typedef $$QuizTableTableCreateCompanionBuilder = QuizTableCompanion Function({
  Value<int> id,
  required String sentence,
  required Map<String, String> options,
  required String correctAnswer,
  required String complexity,
  required String type,
  Value<DateTime> createdAt,
});
typedef $$QuizTableTableUpdateCompanionBuilder = QuizTableCompanion Function({
  Value<int> id,
  Value<String> sentence,
  Value<Map<String, String>> options,
  Value<String> correctAnswer,
  Value<String> complexity,
  Value<String> type,
  Value<DateTime> createdAt,
});

class $$QuizTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $QuizTableTable> {
  $$QuizTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sentence => $state.composableBuilder(
      column: $state.table.sentence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get options => $state.composableBuilder(
          column: $state.table.options,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get correctAnswer => $state.composableBuilder(
      column: $state.table.correctAnswer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$QuizTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $QuizTableTable> {
  $$QuizTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sentence => $state.composableBuilder(
      column: $state.table.sentence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get options => $state.composableBuilder(
      column: $state.table.options,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correctAnswer => $state.composableBuilder(
      column: $state.table.correctAnswer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get complexity => $state.composableBuilder(
      column: $state.table.complexity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$QuizTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuizTableTable,
    QuizTableData,
    $$QuizTableTableFilterComposer,
    $$QuizTableTableOrderingComposer,
    $$QuizTableTableCreateCompanionBuilder,
    $$QuizTableTableUpdateCompanionBuilder,
    (
      QuizTableData,
      BaseReferences<_$AppDatabase, $QuizTableTable, QuizTableData>
    ),
    QuizTableData,
    PrefetchHooks Function()> {
  $$QuizTableTableTableManager(_$AppDatabase db, $QuizTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QuizTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QuizTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sentence = const Value.absent(),
            Value<Map<String, String>> options = const Value.absent(),
            Value<String> correctAnswer = const Value.absent(),
            Value<String> complexity = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              QuizTableCompanion(
            id: id,
            sentence: sentence,
            options: options,
            correctAnswer: correctAnswer,
            complexity: complexity,
            type: type,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sentence,
            required Map<String, String> options,
            required String correctAnswer,
            required String complexity,
            required String type,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              QuizTableCompanion.insert(
            id: id,
            sentence: sentence,
            options: options,
            correctAnswer: correctAnswer,
            complexity: complexity,
            type: type,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuizTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuizTableTable,
    QuizTableData,
    $$QuizTableTableFilterComposer,
    $$QuizTableTableOrderingComposer,
    $$QuizTableTableCreateCompanionBuilder,
    $$QuizTableTableUpdateCompanionBuilder,
    (
      QuizTableData,
      BaseReferences<_$AppDatabase, $QuizTableTable, QuizTableData>
    ),
    QuizTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableTableManager get wordsTable =>
      $$WordsTableTableTableManager(_db, _db.wordsTable);
  $$SentencesTableTableTableManager get sentencesTable =>
      $$SentencesTableTableTableManager(_db, _db.sentencesTable);
  $$QuizTableTableTableManager get quizTable =>
      $$QuizTableTableTableManager(_db, _db.quizTable);
}
