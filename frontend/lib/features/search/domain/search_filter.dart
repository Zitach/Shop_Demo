import 'package:flutter/material.dart';

class SearchFilter {
  final String? query;
  final String? category;
  final DateTimeRange? dateRange;
  final int adults;
  final int children;
  final int infants;
  final double? minPrice;
  final double? maxPrice;
  final SortBy sortBy;

  const SearchFilter({
    this.query,
    this.category,
    this.dateRange,
    this.adults = 1,
    this.children = 0,
    this.infants = 0,
    this.minPrice,
    this.maxPrice,
    this.sortBy = SortBy.relevance,
  });

  SearchFilter copyWith({
    String? query,
    String? category,
    DateTimeRange? dateRange,
    int? adults,
    int? children,
    int? infants,
    double? minPrice,
    double? maxPrice,
    SortBy? sortBy,
  }) {
    return SearchFilter(
      query: query ?? this.query,
      category: category ?? this.category,
      dateRange: dateRange ?? this.dateRange,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      infants: infants ?? this.infants,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  int get totalGuests => adults + children;
}

enum SortBy { relevance, priceLow, priceHigh, rating, newest }
