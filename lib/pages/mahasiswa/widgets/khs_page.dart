import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siakad_indra/bloc/khs/khs_bloc.dart';
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import 'package:siakad_indra/data/models/response/auth_response_model.dart';
import '../../../common/constants/colors.dart';
import '../../../common/widgets/row_text.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KhsPageState();
}

class _KhsPageState extends State<KhsPage> {
  @override
  void initState() {
    super.initState();
    context.read<KhsBloc>().add(const KhsEvent.getKhs());
  }

  double ipk = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // padding: const EdgeInsets.all(24.0),
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            const Text(
              "KHS Mahasiswa",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "14 of 64 results",
                  style: TextStyle(
                    color: ColorName.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: Image.network(
                  'https://lh3.googleusercontent.com/a/ACg8ocJxpra2ZCN9PFP64VYPlvYTGnu-gjIgtWE0oWC4jzNcZ4U=s96-p-k-rw-no',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              title: FutureBuilder(
                future: AuthLocalDatasource().getUser(),
                initialData: "Loading",
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data as User;
                      return Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
              subtitle: const Text(
                "Mahasiswa",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const RowText(
              label: 'Mata Kuliah :',
              value: 'Nilai :',
              labelColor: ColorName.primary,
              valueColor: ColorName.primary,
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: BlocBuilder<KhsBloc, KhsState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return const SizedBox();
                  }, loading: () {
                    ipk = 0;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }, loaded: (data) {
                    data.forEach((element) {
                      ipk += double.parse(element.nilai);
                      debugPrint(element.nilai);
                    });
                    debugPrint(ipk.toString());
                    ipk = ipk / data.length;
                    debugPrint(ipk.toString());

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final listdata = data[index];
                              debugPrint(listdata.subject.title);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: RowText(
                                  label: listdata.subject.title,
                                  value: listdata.grade.toString(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        RowText(
                          label: 'IPK Semester :',
                          value: ipk.toStringAsFixed(2),
                          labelColor: ColorName.primary,
                          valueColor: ColorName.primary,
                        ),
                        SizedBox(
                            // height: MediaQuery.of(context).size.height / 3),
                            height: 20),
                      ],
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
