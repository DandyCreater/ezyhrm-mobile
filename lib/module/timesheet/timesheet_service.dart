import 'package:ezyhr_mobile_apps/module/timesheet/request/timesheet_work_hour_request.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_response.dart';
import 'package:ezyhr_mobile_apps/module/timesheet/response/timesheet_work_hour_response.dart';
import 'package:ezyhr_mobile_apps/shared/services/base_service.dart';
import 'package:ezyhr_mobile_apps/shared/services/session_service.dart';

class TimesheetService {
  static TimesheetService instance = TimesheetService._();
  TimesheetService._();
  factory TimesheetService() => instance;

  final _baseService = BaseService.instance;
  final sessionService = SessionService.instance;

  Future<List<TimesheetDto>> getEmployeeTimesheet(int employeeId) async {
    List<TimesheetDto> response = await _baseService.get(
      '/api/EmployeeTimesheet/${employeeId}',
      responseDecoder: (dynamic response) {
        return ListTimesheetResponseFromJson(response);
      },
    );
    print('response getEmployeeTimesheet: $response');

    return response.where((e) => e.employeeId == employeeId).toList();
  }

  Future<List<TimesheetDto>> getEmployeeTimesheetByMonth(
      int employeeId, int month, int year) async {
    List<TimesheetDto> response = await _baseService.get(
      '/api/EmployeeTimeSheet/ByMonthYear/${month}/${year}',
      responseDecoder: (dynamic response) {
        return ListTimesheetResponseFromJson(response);
      },
    );
    print('response getEmployeeTimesheet: $response');

    final res = response.where((e) => e.employeeId == employeeId).toList();
    return res;
  }

  Future<List<TimesheetDto>> createTimesheet(List<TimesheetDto> req) async {
    print('body');
    print(ListTimesheetDtoToJson(req));
    List<TimesheetDto> response = await _baseService.post(
      '/api/EmployeeTimesheet/multiple/store',
      body: req,
      responseDecoder: (dynamic response) {
        return ListTimesheetResponseFromJson(response);
      },
    );
    print('response getEmployeeTimesheet: $response');

    return response;
  }

  Future<List<TimesheetDto>> updateTimesheet(List<TimesheetDto> req) async {
    List<TimesheetDto> response = await _baseService.post(
      '/api/EmployeeTimeSheet/multiple/update',
      body: ListTimesheetDtoToJson(req),
      responseDecoder: (dynamic response) {
        return ListTimesheetResponseFromJson(response);
      },
    );
    print('response getEmployeeTimesheet: $response');

    return response;
  }

  Future<TimesheetDto> createSingleTimesheet(TimesheetDto req) async {
    TimesheetDto response = await _baseService.post(
      '/api/EmployeeTimeSheet',
      body: req.toJson(),
      responseDecoder: (dynamic response) {
        return TimesheetDto.fromJson(response);
      },
    );
    print('response getEmployeeTimesheet: $response');

    return response;
  }

  Future<TimesheetWorkHourResponse> getTimesheetWorkHour(int employeeId) async {
    TimesheetWorkHourResponse response = await _baseService.postBase(
      'https://ezyhr.rmagroup.com.sg/Public/GetTimesheetWorkHour',
      body: TimesheetWorkHourRequest(
        emploId: employeeId,
        route: sessionService.getInstanceName(),
      ),
      responseDecoder: (dynamic response) {
        return TimesheetWorkHourResponse.fromJson(response);
      },
    );
    print('response getTimesheetWorkHour: $response');

    return response;
  }

  Future<void> deleteTimesheet(int id) async {
    await _baseService.delete(
      '/api/EmployeeTimeSheet/$id',
      responseDecoder: (dynamic response) {
        return response;
      },
    );
  }
}
