
import 'package:bloc_test/bloc_test.dart';
import 'package:deriv_price_tracker/cubit/active_symbols_cubit.dart';
import 'package:deriv_price_tracker/cubit/ticks_cubit.dart';
import 'package:deriv_price_tracker/data/models/base_response.dart';
import 'package:deriv_price_tracker/screens/price_tracker_page/price_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../fake_data/fake_base_response.dart';

class MockActiveSymbolCubit extends MockCubit<BaseState> implements ActiveSymbolsCubit {}

class FakeActiveSymbolState extends Fake implements BaseState {}

class MockTicksCubit extends MockCubit<BaseState> implements TicksCubit {}

class FakeTicksState extends Fake implements BaseState {}


 main() async {
  late MockActiveSymbolCubit activeSymbolCubit;
  late TicksCubit ticksCubit ;

  setUpAll(() {
    registerFallbackValue(FakeActiveSymbolState());
    registerFallbackValue(FakeTicksState());
  });

  setUp(() {
      activeSymbolCubit = MockActiveSymbolCubit();
      ticksCubit = MockTicksCubit();
  });

  Widget makeTestableWidget(
      {required Widget child,
      required ActiveSymbolsCubit mockActiveSymbolsCubit,required TicksCubit mockTicksCubit}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveSymbolsCubit>(
            create: (context) => mockActiveSymbolsCubit),
         BlocProvider<TicksCubit>(
          create: (context) => mockTicksCubit,
        ),
      ],
      child: child,
    );
  }

  testWidgets(' Check not to show loading widget and shows DropDowns Widgets   ', (WidgetTester tester) async {
    when(() => activeSymbolCubit.state).thenReturn( FakeBaseResponse.activeSymbolBaseResponseLoaded);
    when(() => ticksCubit.state).thenReturn( FakeBaseResponse.ticksResponseLoaded);
    when(() => activeSymbolCubit.getActiveSymbolRequest(),).thenAnswer((_)  async {
      emits(FakeBaseResponse.activeSymbolBaseResponseLoaded);
    } );
    await tester.pumpWidget(makeTestableWidget(
        child: const MaterialApp(

          home: PriceTrackerPage(),
        ),
        mockActiveSymbolsCubit: activeSymbolCubit,mockTicksCubit: ticksCubit));
    await tester.pump();
    expect(find.byKey(const Key('loadingWidget')), findsNothing);
    expect(find.byKey(const Key('marketsDropDown')), findsOneWidget);
    expect(find.byKey(const Key('assetsDropDown')), findsOneWidget);
  });



  testWidgets(' Check to show loading widget and not showing DropDowns Widgets on loading state  ', (WidgetTester tester) async {
    when(() => activeSymbolCubit.state).thenReturn( FakeBaseResponse.activeSymbolBaseResponseLoading);
    when(() => ticksCubit.state).thenReturn( FakeBaseResponse.ticksResponseLoading);
    when(() => activeSymbolCubit.getActiveSymbolRequest(),).thenAnswer((_)  async {
      emits(FakeBaseResponse.activeSymbolBaseResponseLoading);
    } );
    await tester.pumpWidget(makeTestableWidget(
        child: const MaterialApp(

          home: PriceTrackerPage(),
        ),
        mockActiveSymbolsCubit: activeSymbolCubit,mockTicksCubit: ticksCubit));
    await tester.pump();
    expect(find.byKey(const Key('loadingWidget')), findsOneWidget);
    expect(find.byKey(const Key('marketsDropDown')), findsNothing);
    expect(find.byKey(const Key('assetsDropDown')), findsNothing);
  });

  testWidgets(' Check the state of Price Widget on loading price   ', (WidgetTester tester) async {
    when(() => activeSymbolCubit.state).thenReturn( FakeBaseResponse.activeSymbolBaseResponseLoaded);
    when(() => ticksCubit.state).thenReturn( FakeBaseResponse.ticksResponseLoading);
    when(() => activeSymbolCubit.getActiveSymbolRequest(),).thenAnswer((_)  async {
      emits(FakeBaseResponse.activeSymbolBaseResponseLoading);
    } );
    await tester.pumpWidget(makeTestableWidget(
        child: const MaterialApp(

          home: PriceTrackerPage(),
        ),
        mockActiveSymbolsCubit: activeSymbolCubit,mockTicksCubit: ticksCubit));
    await tester.pump();
    expect(find.byKey(const Key('priceTextWidget')), findsNothing);
    expect(find.byKey(const Key('priceLoadingWidget')),findsOneWidget);
    expect(find.byKey(const Key('marketsDropDown')), findsOneWidget);
    expect(find.byKey(const Key('assetsDropDown')), findsOneWidget);
  });

 }

