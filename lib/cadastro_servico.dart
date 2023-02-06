import 'package:agendei_app/duration_picker.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class CadastroServico extends StatefulWidget {
  const CadastroServico({Key? key}) : super(key: key);

  @override
  State<CadastroServico> createState() => _CadastroServicoState();
}

class _CadastroServicoState extends State<CadastroServico> {
  final _duration = CustomDuration();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _duration.toFormat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Serviço'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                ),
                maxLength: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLength: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: '0,00',
                decoration: const InputDecoration(
                  labelText: 'Preço (R\$)',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  TextInputMask(mask: '9.999,99', placeholder: '0', maxPlaceHolders: 3, reverse: true, maxLength: 8),
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Duração média de realização',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final result = await showDialog<CustomDuration>(
                    context: context,
                    useSafeArea: true,
                    barrierDismissible: false,
                    builder: (context) {
                      return DurationPicker(initialValue: _duration);
                    },
                  );
                  if (result != null) {
                    setState(() {
                      _duration.copy(result);
                    });
                  }
                  _controller.text = _duration.toFormat();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
