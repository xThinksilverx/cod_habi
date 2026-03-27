import 'package:flutter/material.dart';
import '../models/habito.dart';
import 'habit_details_screen.dart';

const _preto = Color(0xFF0A0A0A);
const _pretoCard = Color(0xFF141414);
const _pretoElevado = Color(0xFF1E1E1E);
const _branco = Color(0xFFFFFFFF);
const _dourado = Color(0xFFD4AF37);
const _douradoClaro = Color(0xFFF0CC5A);
const _cinza = Color(0xFF888888);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _carregando = true;
  List<Habito> _habitos = [];

  @override
  void initState() {
    super.initState();
    _carregarHabitos();
  }

  Future<void> _carregarHabitos() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _habitos = [
        Habito(
          id: '1',
          nome: 'Dormir 8 horas',
          descricao: 'Dormir é bom pra caramba então vamo tentar domrir bastante.',
          sequenciaDias: 5,
        ),
        Habito(
          id: '2',
          nome: 'Procrastinar',
          descricao: 'Esse a gente sabe fazer bem',
          sequenciaDias: 0,
        ),
        Habito(
          id: '3',
          nome: 'Jogar video game',
          descricao: 'Jogar crimson desert po',
          sequenciaDias: 12,
        ),
        Habito(
          id: '4',
          nome: 'Beber agua',
          descricao: 'Tem que beber agua.',
          sequenciaDias: 3,
        ),
        Habito(
          id: '5',
          nome: 'Ler por 30 min',
          descricao: 'LER UNS LIVROS.',
          sequenciaDias: 7,
        ),
        Habito(
          id: '6',
          nome: 'Fazer exercicio',
          descricao: 'Praticar atividade fisica',
          sequenciaDias: 2,
        ),
      ];
      _carregando = false;
    });
  }

  int get _concluidosCount => _habitos.where((h) => h.concluido).length;
  double get _progresso => _habitos.isEmpty ? 0 : _concluidosCount / _habitos.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _preto,
      body: SafeArea(
        child: _carregando ? _buildCarregando() : _buildConteudo(),
      ),
    );
  }

  Widget _buildCarregando() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: _dourado,
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'VASCÃOOOOOOOOOOO',
            style: TextStyle(
              color: _dourado,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Carregando',
            style: TextStyle(
              color: _branco.withOpacity(0.3),
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConteudo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCabecalho(),
        _buildProgresso(),
        const SizedBox(height: 4),
        Expanded(child: _buildLista()),
      ],
    );
  }

  Widget _buildCabecalho() {
    final agora = DateTime.now();
    final dias = ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM'];
    final meses = ['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'];

    return Container(
      decoration: BoxDecoration(
        color: _pretoCard,
        border: Border(
          bottom: BorderSide(color: _dourado.withOpacity(0.25), width: 1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'VASCÃOOOOOOOOOOO',
                style: TextStyle(
                  color: _dourado,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Habitos',
                style: TextStyle(
                  color: _branco,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_concluidosCount de ${_habitos.length} FEitos hoje',
                style: const TextStyle(color: _cinza, fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: _dourado.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${dias[agora.weekday - 1]}  ${agora.day}  ${meses[agora.month - 1]}',
              style: const TextStyle(
                color: _dourado,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgresso() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PROGRESSO DO DIA',
                style: TextStyle(
                  color: _cinza,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '${(_progresso * 100).toInt()}%',
                style: const TextStyle(
                  color: _dourado,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: _branco.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _progresso,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_dourado, _douradoClaro],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLista() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      itemCount: _habitos.length,
      itemBuilder: (context, index) => _buildItemHabito(_habitos[index]),
    );
  }

  Widget _buildItemHabito(Habito habito) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HabitDetailsScreen(
                habito: habito,
                onToggle: (valor) => setState(() => habito.concluido = valor),
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: habito.concluido ? _dourado.withOpacity(0.07) : _pretoCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: habito.concluido
                  ? _dourado.withOpacity(0.35)
                  : _branco.withOpacity(0.06),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: habito.concluido
                      ? _dourado.withOpacity(0.15)
                      : _pretoElevado,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: habito.concluido
                        ? _dourado.withOpacity(0.5)
                        : _branco.withOpacity(0.08),
                  ),
                ),
                child: Icon(
                  habito.concluido ? Icons.check : Icons.radio_button_unchecked,
                  color: habito.concluido ? _dourado : _cinza,
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (habito.concluido)
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Text(
                            habito.nome,
                            style: TextStyle(
                              color: _branco.withOpacity(0.3),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Positioned(
                            top: 9,
                            left: 0,
                            right: 0,
                            child: Container(height: 1.5, color: Colors.red.shade700),
                          ),
                        ],
                      )
                    else
                      Text(
                        habito.nome,
                        style: const TextStyle(
                          color: _branco,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 13,
                          color: habito.sequenciaDias > 0
                              ? _dourado
                              : _branco.withOpacity(0.15),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${habito.sequenciaDias} dias seguidos',
                          style: const TextStyle(color: _cinza, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: habito.concluido,
                onChanged: (valor) => setState(() => habito.concluido = valor),
                activeColor: _preto,
                activeTrackColor: _dourado,
                inactiveThumbColor: _cinza,
                inactiveTrackColor: _branco.withOpacity(0.08),
              ),
            ],
          ),
        ),
      ),
    );
  }
}