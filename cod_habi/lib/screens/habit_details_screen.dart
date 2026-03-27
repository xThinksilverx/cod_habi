import 'package:flutter/material.dart';
import '../models/habito.dart';

const _preto = Color(0xFF0A0A0A);
const _pretoCard = Color(0xFF141414);
const _pretoElevado = Color(0xFF1E1E1E);
const _branco = Color(0xFFFFFFFF);
const _dourado = Color(0xFFD4AF37);
const _douradoClaro = Color(0xFFF0CC5A);
const _cinza = Color(0xFF888888);

class HabitDetailsScreen extends StatefulWidget {
  final Habito habito;
  final Function(bool) onToggle;

  const HabitDetailsScreen({
    super.key,
    required this.habito,
    required this.onToggle,
  });

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  late bool _concluido;

  @override
  void initState() {
    super.initState();
    _concluido = widget.habito.concluido;
  }

  void _alternarConcluido(bool valor) {
    setState(() => _concluido = valor);
    widget.onToggle(valor);
    widget.habito.concluido = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _preto,
      appBar: AppBar(
        backgroundColor: _pretoCard,
        foregroundColor: _branco,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: _branco.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: _branco),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DETALHES DO HABITO',
          style: TextStyle(
            color: _cinza,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: _dourado.withOpacity(0.25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCartaoPrincipal(),
            const SizedBox(height: 16),
            _buildSecaoStatus(),
            const SizedBox(height: 16),
            _buildSecaoEstatisticas(),
            const SizedBox(height: 16),
            _buildSecaoDescricao(),
            const SizedBox(height: 28),
            _buildBotaoToggle(),
            const SizedBox(height: 16),
            _buildRodape(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartaoPrincipal() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: _pretoCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _concluido
              ? _dourado.withOpacity(0.45)
              : _branco.withOpacity(0.06),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _concluido ? _dourado.withOpacity(0.12) : _pretoElevado,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _concluido ? _dourado.withOpacity(0.4) : _branco.withOpacity(0.08),
              ),
            ),
            child: Icon(
              _concluido ? Icons.check_rounded : Icons.pending_actions,
              color: _concluido ? _dourado : _cinza,
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          if (_concluido)
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  widget.habito.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _branco.withOpacity(0.3),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 0,
                  right: 0,
                  child: Container(height: 2, color: Colors.red.shade700),
                ),
              ],
            )
          else
            Text(
              widget.habito.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _branco,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _concluido ? _dourado.withOpacity(0.12) : _pretoElevado,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _concluido ? _dourado.withOpacity(0.35) : _branco.withOpacity(0.06),
              ),
            ),
            child: Text(
              _concluido ? 'CONCLUIDO HOJE' : 'PENDENTE',
              style: TextStyle(
                color: _concluido ? _dourado : _cinza,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: _pretoCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _branco.withOpacity(0.06)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MARCAR COMO FEITO',
                style: TextStyle(
                  color: _cinza,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _concluido ? 'Habito realizado hoje' : 'Ainda nao realizado',
                style: const TextStyle(color: _branco, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Switch(
            value: _concluido,
            onChanged: _alternarConcluido,
            activeColor: _preto,
            activeTrackColor: _dourado,
            inactiveThumbColor: _cinza,
            inactiveTrackColor: _branco.withOpacity(0.08),
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoEstatisticas() {
    return Row(
      children: [
        Expanded(
          child: _buildCard(
            icone: Icons.local_fire_department,
            corIcone: _dourado,
            valor: '${widget.habito.sequenciaDias}',
            label: 'DIAS SEGUIDOS',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildCard(
            icone: Icons.check_circle_outline,
            corIcone: _concluido ? _dourado : _cinza,
            valor: _concluido ? 'SIM' : 'NAO',
            label: 'FEITO HOJE',
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icone,
    required Color corIcone,
    required String valor,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _pretoCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _branco.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: corIcone, size: 22),
          const SizedBox(height: 12),
          Text(
            valor,
            style: const TextStyle(
              color: _branco,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: _cinza,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoDescricao() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _pretoCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _branco.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DESCRICAO',
            style: TextStyle(
              color: _cinza,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.habito.descricao,
            style: TextStyle(
              color: _branco.withOpacity(0.75),
              fontSize: 14,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoToggle() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () => _alternarConcluido(!_concluido),
        style: ElevatedButton.styleFrom(
          backgroundColor: _concluido ? Colors.red.shade900 : _dourado,
          foregroundColor: _concluido ? _branco : _preto,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          _concluido ? 'DESMARCAR HABITO' : 'MARCAR COMO FEITO',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildRodape() {
    return Center(
      child: Text(
        'VASCÃOOOOOOO',
        style: TextStyle(
          color: _dourado.withOpacity(0.25),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
    );
  }
}